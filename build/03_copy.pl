#!/usr/bin/env perl

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
# Copy machine types from CSV export to SQLite database
#

use utf8;
binmode(STDOUT, ':encoding(utf8)');
use strict;
use DBI;

# CSV files without .csv
my $csv_gcloud_machine_types       = 'machinetypes';
my $csv_gcloud_zones               = 'zones';
my $csv_gcloud_disk_types          = 'disktypes';
my $csv_gcloud_images              = 'images';
my $csv_gcloud_community_images    = 'imagescommunity';
my $csv_gcloud_deeplearning_images = 'imagesdeeplearning';

# SQLite database file
my $db_file  = 'gce.db';

# Open CSV
my $csv = DBI->connect("dbi:CSV:", undef, undef, {
	f_ext        => ".csv/r",
	csv_sep_char => ";",
	csv_class    => "Text::CSV_XS",
	RaiseError   => 1,
}) or die "ERROR: Cannot connect $DBI::errstr\n";

# Open DB
my $db = DBI->connect("dbi:SQLite:dbname=$db_file","","") or die "ERROR: Cannot connect $DBI::errstr\n";


###############################################################################
# MACHINE TYPES
###############################################################################

print "Machine types\n";
$db->do("DELETE FROM machinetypes") or die "ERROR: Cannot delete table $DBI::errstr\n";

# Select machine types from CSV
my $select = qq ~
SELECT 
	name, description, zone,
	guestCpus, isSharedCpu,
	memoryGB,
	guestAcceleratorCount, guestAcceleratorType,
	maximumPersistentDisks, maximumPersistentDisksSizeGb,
	deprecated
FROM $csv_gcloud_machine_types
~;
my $sth = $csv->prepare($select);
$sth->execute;
$sth->bind_columns (\my (
	$name, $description, $zone,
	$guestCpus, $isSharedCpu,
	$memoryGB,
	$guestAcceleratorCount, $guestAcceleratorType,
	$maximumPersistentDisks, $maximumPersistentDisksSizeGb,
	$deprecated
));
# Create values for insert
my @values = ();
while ($sth->fetch) {
	next if ($deprecated); # Skip deprecated machine-types
	print "$name, $zone\n";
	# Location and region
	my @zone_parts = split(/-/, $zone);
	my $location   = "$zone_parts[0]";
	my $region     = "$zone_parts[0]-$zone_parts[1]";
	$isSharedCpu   = lc($isSharedCpu);
	# Create value for SQL INSERT
	my $value = qq ~
		 (
			'$name', '$description', '$location', '$region', '$zone',
			'$guestCpus', '$isSharedCpu',
			'$memoryGB',
			'$guestAcceleratorCount', '$guestAcceleratorType',
			'$maximumPersistentDisks', '$maximumPersistentDisksSizeGb'
		)
	~;
	$value =~ s/\t//g;
	push(@values, $value);
}
$sth->finish;
# Insert machine types to database table
my $insert = qq ~
INSERT INTO machinetypes (
	'name', 'description', 'location', 'region', 'zone',
	'guestCpus', 'isSharedCpu',
	'memoryGB',
	'guestAcceleratorCount', 'guestAcceleratorType',
	'maximumPersistentDisks', 'maximumPersistentDisksSizeGb'
) VALUES
~;
$insert .= join(",", @values);
$insert .= ";\n";
$db->do($insert) or die "ERROR: Cannot insert machine types $DBI::errstr\n";


###############################################################################
# ZONES
###############################################################################

print "Zones\n";
$db->do("DELETE FROM zones") or die "ERROR: Cannot delete table $DBI::errstr\n";

# Select machine types from CSV
my $select_zones = "SELECT name, availableCpuPlatforms FROM $csv_gcloud_zones";
$sth = $csv->prepare($select_zones);
$sth->execute;
$sth->bind_columns (\my ($name, $availableCpuPlatforms));
# Create values for insert
my @zones = ();
while ($sth->fetch) {
	print "$name\n";
	# Create value for SQL INSERT
	my $zone = "('$name', '$availableCpuPlatforms')";
	push(@zones, $zone);
}
$sth->finish;

my $insert_zones = "INSERT INTO zones ('name', 'availableCpuPlatforms') VALUES";
$insert_zones .= join(",", @zones);
$insert_zones .= ";\n";
$db->do($insert_zones) or die "ERROR: Cannot insert zones $DBI::errstr\n";

###############################################################################
# DISK TYPES
###############################################################################

print "Disk types\n";
$db->do("DELETE FROM disktypes") or die "ERROR: Cannot delete table $DBI::errstr\n";

# Select disk types from CSV
my $select_disks = "SELECT name, description, zone FROM $csv_gcloud_disk_types";
$sth = $csv->prepare($select_disks);
$sth->execute;
$sth->bind_columns (\my ($name, $description, $zone));
# Create values for insert
my @disks = ();
while ($sth->fetch) {
	print "$name, $zone\n";
	# Location and region
	my @zone_parts = split(/-/, $zone);
	my $location   = "$zone_parts[0]";
	my $region     = "$zone_parts[0]-$zone_parts[1]";
	# Create value for SQL INSERT
	my $value = "('$name', '$description', '$location', '$region', '$zone')";
	push(@disks, $value);
}
$sth->finish;
# Insert machine types to database table
my $insert_disks = qq ~
INSERT INTO disktypes (
	'name',
	'description',
	'location',
	'region',
	'zone'
) VALUES
~;
$insert_disks .= join(",", @disks);
$insert_disks .= ";\n";
$db->do($insert_disks) or die "ERROR: Cannot insert disk types $DBI::errstr\n";


###############################################################################
# IMAGES
###############################################################################

print "Images\n";
$db->do("DELETE FROM images") or die "ERROR: Cannot delete table $DBI::errstr\n";

my $insert_images = qq ~
INSERT INTO images (
	'name',
	'description',
	'diskSizeGb',
	'project',
	'family',
	'architecture',
	'creation'
) VALUES
~;
my $select_images = "SELECT name, description, diskSizeGb, project, family, architecture, creation FROM $csv_gcloud_images WHERE status LIKE 'READY'";
$sth = $csv->prepare($select_images);
$sth->execute;
$sth->bind_columns (\my ($name, $description, $diskSizeGb, $project, $family, $architecture, $creation));
while ($sth->fetch) {
	print "$project, $family, $name\n";
	my $value = "$insert_images ('$name', '$description', '$diskSizeGb', '$project', '$family', '$architecture', '$creation')";
	$db->do($value) or die "ERROR: Cannot insert images $DBI::errstr\n";
}
$sth->finish;

print "DONE\n";
