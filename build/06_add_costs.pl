#!/usr/bin/perl

# Copyright 2022 Nils Knieling. All Rights Reserved.
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

foreach my $machine (keys %{ $gcp->{'compute'}->{'instance'} }) {
	print "$machine\n";
	# OS license per month
	my $sles      = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'sles'}->{'month'};
	my $slesSap   = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'sles-sap'}->{'month'};
	my $slesSap1y = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'sles-sap'}->{'month_1y'} || $slesSap;
	my $slesSap3y = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'sles-sap'}->{'month_3y'} || $slesSap;
	my $rhel      = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'rhel'}->{'month'};
	my $rhelSap   = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'rhel-sap'}->{'month'};
	my $windows   = $gcp->{'compute'}->{'license'}->{$machine}->{'cost'}->{'windows'}->{'month'};
	foreach my $region (keys %{ $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'} }) {
		print "\t$region\n";
		# vCPU and memory in region per hour and month
		my $hour     = $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'}->{$region}->{'hour'};
		my $month    = $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'}->{$region}->{'month'};
		my $month_1y = $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'}->{$region}->{'month_1y'} || $month;
		my $month_3y = $gcp->{'compute'}->{'instance'}->{$machine}->{'cost'}->{$region}->{'month_3y'} || $month;
		my $update = qq ~
		UPDATE instances SET
			hour              = '$hour',
			month             = '$month',
			month1yCud        = '$month_1y',
			month3yCud        = '$month_3y',
			monthSles         = '$sles',
			monthSlesSap      = '$slesSap',
			monthSlesSap1yCud = '$slesSap1y',
			monthSlesSap3yCud = '$slesSap3y',
			monthRhel         = '$rhel',
			monthRhelSap      = '$rhelSap',
			monthWindows      = '$windows'
		WHERE name LIKE '$machine' AND region LIKE '$region'
		~;
		$db->do($update) or die "ERROR: Cannot update $DBI::errstr\n";
	}
}

# Update region location
print "Region Locations\n";
foreach my $region (keys %{ $gcp->{'region'} }) {
	my $regionLocation = $gcp->{'region'}->{$region}->{'location'};
	print "$region : $regionLocation\n";
	my $update = "UPDATE instances SET regionLocation = '$regionLocation' WHERE region LIKE '$region'";
	$db->do($update) or die "ERROR: Cannot update $DBI::errstr\n";
}

print "DONE\n";
