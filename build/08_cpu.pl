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
# Check available CPU platforms per instance in region and update machine type
#

use utf8;
binmode(STDOUT, ':encoding(utf8)');
use strict;
use DBI;
use Data::Dumper;

my $db_file  = 'gce.db';

# Open DB
my $db = DBI->connect("dbi:SQLite:dbname=$db_file","","") or die "ERROR: Cannot connect $DBI::errstr\n";

print "\nZones\n";
my $select_zones = "SELECT name, availableCpuPlatforms FROM zones ORDER BY name";
my $sth = $db->prepare($select_zones);
$sth->execute;
$sth->bind_columns ( \my ($zone, $availableCpuPlatforms) );
my $cpuPlatforms = {}; # all CPU platforms
my $availableCpuPlatformsInRegion = {}; # available CPU platforms in region
while ($sth->fetch) {
	print "$zone\n";
	my @zone_parts = split(/-/, $zone);
	my $location   = "$zone_parts[0]";
	my $region     = "$zone_parts[0]-$zone_parts[1]";
	# Store CPU platform in Perl Hash reference
	foreach my $cpu (split(',', $availableCpuPlatforms)) {
		$availableCpuPlatformsInRegion->{"$region"}->{"$cpu"} = '1';
		$cpuPlatforms->{"$cpu"} = '1';
	}
}

print "\nMachine types\n";
my $select_instances = "SELECT name, region, cpuPlatform FROM instances";
my $sth = $db->prepare($select_instances);
$sth->execute;
$sth->bind_columns ( \my ($name, $region, $cpuPlatform) );
my %unknown_cpuPlatform = ();
while ($sth->fetch) {
	print "$name, $region\n";
	my @cpuPlatformsInRegion    = (); # available CPU platforms for machine type in the region, cross-checked with the available CPU platforms in the zones.
	my @cpuPlatformsForInstance = (); # CPU platforms for machine type
	foreach my $instance_cpuPlatform (sort split(',', $cpuPlatform)) {
		print "\t$instance_cpuPlatform";
		# Check if the CPU platform of the instance is known
		my $found = 0;
		foreach my $cpu (keys %{$cpuPlatforms}) {
			if ($cpu =~ m/$instance_cpuPlatform/i) {
				$found = '1';
				push (@cpuPlatformsForInstance, $cpu); # Store longer name
			}
		}
		if ($found) {
			print " [found]";
			# Check if CPU platform for this machine type is available in the region
			foreach my $cpu (keys %{$availableCpuPlatformsInRegion->{"$region"}}) {
				if ($cpu =~ m/$instance_cpuPlatform/i) {
					print " [available]";
					push (@cpuPlatformsInRegion, $cpu);
				}
			}
		} else {
			print " [unknown]";
			$unknown_cpuPlatform{"$instance_cpuPlatform"} = '1';
		}
		print "\n";
	}
	# CPU platform for machine type
	my $update_cpuPlatformCount          = scalar @cpuPlatformsForInstance;
	my $update_cpuPlatform               = join(', ', sort @cpuPlatformsForInstance);
	# CPU platform for machine type and available in region
	my $update_availableCpuPlatformCount = scalar @cpuPlatformsInRegion;
	my $update_availableCpuPlatform      = join(', ', sort @cpuPlatformsInRegion);
	# Set Intel and AMD
	my $intel = '0';
	   $intel = '1' if ($update_availableCpuPlatform =~ m/intel/i );
	my $amd   = '0';
	   $amd   = '1' if ($update_availableCpuPlatform =~ m/amd/i );
	my $arm   = '0';
	   $arm   = '1' if ($update_availableCpuPlatform =~ m/ampere/i );
	   $arm   = '1' if ($update_availableCpuPlatform =~ m/axion/i );
	my $update = qq ~
		UPDATE instances
		SET
			intel = '$intel',
			amd   = '$amd',
			arm   = '$arm',
			cpuPlatformCount          = '$update_cpuPlatformCount',          cpuPlatform          = '$update_cpuPlatform',
			availableCpuPlatformCount = '$update_availableCpuPlatformCount', availableCpuPlatform = '$update_availableCpuPlatform'
		WHERE name LIKE '$name'
		AND region LIKE '$region'
	~;
	$db->do($update) or die "ERROR: Cannot update available CPU platform for instance in region $DBI::errstr\n";
}

if (keys %unknown_cpuPlatform) {
	print "Unknown CPU platforms:\n";
	foreach my $cpu (keys %unknown_cpuPlatform) {
		print "\t $cpu\n";
	}
	die "Please check and fix!\n";
}

print "\nClean up unavailable CPU platforms\n";
my $select_not_available = "SELECT name, region FROM instances WHERE availableCpuPlatformCount == '0'";
my $sth = $db->prepare($select_not_available);
$sth->execute;
$sth->bind_columns ( \my ($name, $region) );
my $unavailable = 0;
while ($sth->fetch) {
	print "$name, $region\n";
	$unavailable++;
}
$db->do("DELETE FROM instances WHERE availableCpuPlatformCount == '0'") or die "ERROR: Cannot clean up unavailable CPU platforms $DBI::errstr\n";
if ($unavailable) {
	print "Unavailable CPU platforms for machine type in region: $unavailable\n";
}

print "DONE\n";
