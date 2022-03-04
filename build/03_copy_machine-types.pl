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
# Copy machine types from CSV export to SQLite database
#

use utf8;
binmode(STDOUT, ':encoding(utf8)');
use strict;
use DBI;

my $csv_file = 'machinetypes'; # without .csv
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

# Select machine types from CSV
my $select = qq ~
SELECT 
	name, description, zone,
	guestCpus, isSharedCpu,
	memoryGiB,
	guestAcceleratorCount, guestAcceleratorType,
	maximumPersistentDisks, maximumPersistentDisksSizeGb,
	deprecated
FROM $csv_file
~;
my (
	$name, $description, $zone,
	$guestCpus, $isSharedCpu,
	$memoryGiB,
	$guestAcceleratorCount, $guestAcceleratorType,
	$maximumPersistentDisks, $maximumPersistentDisksSizeGb,
	$deprecated
);
my $sth = $csv->prepare($select);
$sth->execute;
$sth->bind_columns (undef,
	\$name, \$description, \$zone,
	\$guestCpus, \$isSharedCpu,
	\$memoryGiB,
	\$guestAcceleratorCount, \$guestAcceleratorType,
	\$maximumPersistentDisks, \$maximumPersistentDisksSizeGb,
	\$deprecated
);

# Insert machine-type to DB
printf("%-16s | %.32s\n", "Name", "Zone");
printf("%-17s+%.33s\n", "-"x17, "-"x33);
my @values = ();
while ($sth->fetch) {
	next if ($deprecated); # Skip deprecated machine-types
	printf("%-16s | %.32s\n", $name, $zone);
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
INSERT INTO machinetypes (
	'name', 'description', 'location', 'region', 'zone',
	'guestCpus', 'isSharedCpu',
	'memoryGiB',
	'guestAcceleratorCount', 'guestAcceleratorType',
	'maximumPersistentDisks', 'maximumPersistentDisksSizeGb'
) VALUES
~;
$insert .= join(",", @values);
$insert .= ";\n";
$db->do($insert) or die "ERROR: Cannot insert $DBI::errstr\n";

print "DONE\n";
