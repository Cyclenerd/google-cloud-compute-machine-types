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
# Copy machine types per region to instances table
#

use utf8;
binmode(STDOUT, ':encoding(utf8)');
use strict;
use DBI;

my $db_file  = 'gce.db';

# Open DB
my $db = DBI->connect("dbi:SQLite:dbname=$db_file","","") or die "ERROR: Cannot connect $DBI::errstr\n";

# Select machine types from CSV
my $select = qq ~
SELECT
	name, description, location, region, 
	(SELECT COUNT(zone)        FROM machinetypes WHERE name LIKE M.name AND region LIKE M.region)               AS zoneCount,
	(SELECT GROUP_CONCAT(zone) FROM machinetypes WHERE name LIKE M.name AND region LIKE M.region ORDER BY zone) AS zones,
	guestCpus, isSharedCpu,
	memoryGiB,
	guestAcceleratorCount, guestAcceleratorType,
	maximumPersistentDisks, maximumPersistentDisksSizeGb
FROM machinetypes M
GROUP BY name, region;
~;
my (
	$name, $description, $location, $region,
	$zoneCount,
	$zones,
	$guestCpus, $isSharedCpu,
	$memoryGiB,
	$guestAcceleratorCount, $guestAcceleratorType,
	$maximumPersistentDisks, $maximumPersistentDisksSizeGb
);
my $sth = $db->prepare($select);
$sth->execute;
$sth->bind_columns (undef,
	\$name, \$description, \$location, \$region,
	\$zoneCount,
	\$zones,
	\$guestCpus, \$isSharedCpu,
	\$memoryGiB,
	\$guestAcceleratorCount, \$guestAcceleratorType,
	\$maximumPersistentDisks, \$maximumPersistentDisksSizeGb
);

# Insert machine-type per region to DB
printf("%-16s | %.32s\n", "Name", "Region");
printf("%-17s+%.33s\n", "-"x17, "-"x33);
my @values = ();
while ($sth->fetch) {
	printf("%-16s | %.32s\n", $name, $region);
	# Create value for SQL INSERT
	my $value = qq ~
		 (
			'$name', '$description', '$location', '$region', '$zoneCount', '$zones',
			'$guestCpus', '$isSharedCpu',
			'$memoryGiB',
			'$guestAcceleratorCount', '$guestAcceleratorType',
			'$maximumPersistentDisks', '$maximumPersistentDisksSizeGb'
		)
	~;
	$value =~ s/\t//g;
	push(@values, $value);
}
$sth->finish;

my $insert = qq ~
INSERT INTO instances (
	'name', 'description', 'location', 'region', 'zoneCount', 'zones',
	'vCpus', 'sharedCpu',
	'memoryGiB',
	'acceleratorCount', 'acceleratorType',
	'disks', 'disksSizeGb'
) VALUES
~;
$insert .= join(",", @values);
$insert .= ";\n";
$db->do($insert) or die "ERROR: Cannot insert $DBI::errstr\n";

print "DONE\n";
