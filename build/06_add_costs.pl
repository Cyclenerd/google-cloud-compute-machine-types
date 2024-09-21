#!/usr/bin/perl

# Copyright 2022-2024 Nils Knieling. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Add costs for machine types in region from pricing (https://github.com/Cyclenerd/google-cloud-pricing-cost-calculator)
#

use utf8;
binmode(STDOUT, ':encoding(utf8)');
use strict;
use DBI;
use YAML::XS qw(LoadFile);
use App::Options (
	option => {
		pricing => {
			required    => 1,
			default     => 'pricing.yml',
			description => "YAML file with GCP pricing information"
		},
	},
);

# Open DB
my $db_file  = 'gce.db';
my $db = DBI->connect("dbi:SQLite:dbname=$db_file","","") or die "ERROR: Cannot connect $DBI::errstr\n";

# Load YAML file with GCP information
my $pricing_file = $App::options{pricing};
unless (-r "$pricing_file") { # read
	die "ERROR: Cannot open YAML file '$pricing_file' for GCP information import!\n";
}
my $gcp = LoadFile("$pricing_file");


###############################################################################
# INSTANCES
###############################################################################
print "\nInstances\n";

foreach my $machine (keys %{ $gcp->{'compute'}->{'instance'} }) {
	print "$machine\n";
	# OS license per month
	my $sles      = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'sles'}->{'month'};
	my $slesSap   = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'sles-sap'}->{'month'};
	my $slesSap1y = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'sles-sap'}->{'month_1y'} || $slesSap;
	my $slesSap3y = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'sles-sap'}->{'month_3y'} || $slesSap;
	my $rhel      = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'rhel'}->{'month'};
	my $rhel1y    = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'rhel'}->{'month_1y'} || $rhel;
	my $rhel3y    = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'rhel'}->{'month_3y'} || $rhel;
	my $rhelSap   = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'rhel-sap'}->{'month'};
	my $rhelSap1y = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'rhel-sap'}->{'month_1y'} || $rhelSap;
	my $rhelSap3y = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'rhel-sap'}->{'month_3y'} || $rhelSap;
	my $windows   = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'windows'}->{'month'};
	foreach my $region (keys %{ $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'} }) {
		print "\t$region\n";
		# vCPU and memory in region per hour and month
		my $hour       = $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'}->{$region}->{'hour'}       || '0.0';
		my $hour_spot  = $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'}->{$region}->{'hour_spot'}  || $hour;
		my $month      = $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'}->{$region}->{'month'}      || '0.0';
		my $month_1y   = $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'}->{$region}->{'month_1y'}   || $month;
		my $month_3y   = $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'}->{$region}->{'month_3y'}   || $month;
		my $month_spot = $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'}->{$region}->{'month_spot'} || $month;

		my $update = qq ~
		UPDATE instances SET
			hour                      = '$hour',
			hourSpot                  = '$hour_spot',
			month                     = '$month',
			month1yCud                = '$month_1y',
			month3yCud                = '$month_3y',
			monthSpot                 = '$month_spot',
			monthSles                 = '$sles',
			monthSlesSap              = '$slesSap',
			monthSlesSap1yCud         = '$slesSap1y',
			monthSlesSap3yCud         = '$slesSap3y',
			monthRhel                 = '$rhel',
			monthRhel1yCud            = '$rhel1y',
			monthRhel3yCud            = '$rhel3y',
			monthRhelSap              = '$rhelSap',
			monthRhelSap1yCud         = '$rhelSap1y',
			monthRhelSap3yCud         = '$rhelSap3y',
			monthWindows              = '$windows'
		WHERE name LIKE '$machine' AND region LIKE '$region'
		~;
		$db->do($update) or die "ERROR: Cannot update $DBI::errstr\n";
	}
}


###############################################################################
# DISKS
###############################################################################
print "\nDisks\n";

# gcosts -> gcloud disk-types name mapping
my %storage_types = (
	'local'             => 'local-ssd',
	'balanced'          => 'pd-balanced',
	'extreme'           => 'pd-extreme',
	'ssd'               => 'pd-ssd',
	'hdd'               => 'pd-standard',
	'hdd'               => 'pd-standard',
	'hyperdisk-extreme' => 'hyperdisk-extreme',
);
foreach my $storage_type (keys %storage_types) {
	my $disk_type = $storage_types{$storage_type};
	print "$storage_type [$disk_type]\n";
	foreach my $region (keys %{ $gcp->{'compute'}->{'storage'}->{$storage_type}->{'cost'} }) {
		print "\t$region\n";
		my $month = $gcp->{'compute'}->{'storage'}->{$storage_type}->{'cost'}->{$region}->{'month'};
		my $update = "UPDATE disks SET monthGb = '$month' WHERE name LIKE '$disk_type' AND region LIKE '$region'";
		$db->do($update) or die "ERROR: Cannot update $DBI::errstr\n";
	}
}


###############################################################################
# LOCATION NAME
###############################################################################
print "\nRegion Locations\n";

# Update region location
foreach my $region (keys %{ $gcp->{'region'} }) {
	my $regionLocation = $gcp->{'region'}->{$region}->{'location'};
	print "$region : $regionLocation\n";
	$db->do("UPDATE instances SET regionLocation = '$regionLocation', regionLocationLong = '$regionLocation' WHERE region LIKE '$region'") or die "ERROR: Cannot update $DBI::errstr\n";
	$db->do("UPDATE disks SET regionLocation = '$regionLocation' WHERE region LIKE '$region'") or die "ERROR: Cannot update $DBI::errstr\n";
}


###############################################################################
# TEST
###############################################################################
print "\nTest\n";

# Check regions without location
my $sth = $db->prepare("SELECT region FROM instances WHERE regionLocation LIKE '' GROUP BY region");
$sth->execute;
$sth->bind_columns (\my ($region));
while ($sth->fetch) {
	print "WARNING: Location of region '$region' missing!\n";
	my $deleteLocation = "DELETE FROM instances WHERE region LIKE '$region'";
	$db->do($deleteLocation) or die "ERROR: Cannot delete instances in unknown location $DBI::errstr\n";
}

# Check disks without price
$sth = $db->prepare("SELECT name, region FROM disks WHERE monthGb <= 0");
$sth->execute;
$sth->bind_columns (\my ($name, $region));
while ($sth->fetch) {
	print "WARNING: Costs per month missing for disk type '$name' in region '$region'.\n";
}

# Chech instances without price
$sth = $db->prepare("SELECT name, region FROM instances WHERE hour <= 0");
$sth->execute;
$sth->bind_columns (\my ($name, $region));
while ($sth->fetch) {
	print "WARNING: Costs per hour missing for machine type '$name' in region '$region'.\n";
	my $deleteInstance = "DELETE FROM instances WHERE name LIKE '$name' AND region LIKE '$region'";
	$db->do($deleteInstance) or die "ERROR: Cannot delete instance without price $DBI::errstr\n";
}

print "DONE\n";
