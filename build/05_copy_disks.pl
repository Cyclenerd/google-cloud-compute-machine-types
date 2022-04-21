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
# Copy disk types per region to disks table
#

use utf8;
binmode(STDOUT, ':encoding(utf8)');
use strict;
use DBI;

my $db_file  = 'gce.db';

# Open DB
my $db = DBI->connect("dbi:SQLite:dbname=$db_file","","") or die "ERROR: Cannot connect $DBI::errstr\n";

###############################################################################
# Copy DISK TYPES to DISKS
###############################################################################
$db->do("DELETE FROM disks") or die "ERROR: Cannot delete table $DBI::errstr\n";

# Select 'disktypes'
my $select = qq ~
SELECT
	name, description, location, region, 
	(SELECT COUNT(zone)        FROM disktypes WHERE name LIKE D.name AND region LIKE D.region)               AS zoneCount,
	(SELECT GROUP_CONCAT(zone) FROM disktypes WHERE name LIKE D.name AND region LIKE D.region ORDER BY zone) AS zones
FROM disktypes D
GROUP BY name, region;
~;
my $sth = $db->prepare($select);
$sth->execute;
$sth->bind_columns ( \my (
	$name, $description, $location, $region,
	$zoneCount,
	$zones
));

# Insert disk type per region to disks table
my @values = ();
while ($sth->fetch) {
	print "$name, $region\n";
	# Sort zones
	my @zones_unsorted = split(',', $zones);
	$zones = join(', ', sort @zones_unsorted);
	# Create value for SQL INSERT
	my $value = "('$name', '$description', '$location', '$region', '$zoneCount', '$zones')";
	push(@values, $value);
}
$sth->finish;

my $insert = qq ~
INSERT INTO disks (
	'name',
	'description',
	'location',
	'region',
	'zoneCount',
	'zones'
) VALUES
~;
$insert .= join(",", @values);
$insert .= ";\n";
$db->do($insert) or die "ERROR: Cannot insert $DBI::errstr\n";

print "DONE\n";
