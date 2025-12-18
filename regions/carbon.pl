#!/usr/bin/perl

# Copyright 2022-2025 Nils Knieling. All Rights Reserved.
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

use strict;
use DBI;

my $dbh = DBI->connect("dbi:CSV:", undef, undef, {
	f_ext        => ".csv/r",
	csv_sep_char => ",",
	csv_class    => "Text::CSV_XS",
	RaiseError   => 1,
}) or die "ERROR: Cannot connect $DBI::errstr\n";

# CSV col names:
#   Google Cloud Region,
#   Location,
#   Google CFE,
#   Grid carbon intensity (gCO2eq / kWh)
my $sth = $dbh->prepare("SELECT * FROM carbon");
$sth->execute();
$sth->bind_columns(\my ($region, $location, $cfe, $co2_kwh));
print "/*\n";
print " * GENERATED WITH carbon.pl\n";
print " * Please see: https://github.com/Cyclenerd/google-cloud-compute-machine-types/blob/master/regions/README.md\n";
print " */\n";
while ($sth->fetch) {
	if ($region) {
		# Google Cloud Region
		$region  =~ s/\s//;
		# Google CFE%
		if ($cfe =~ /^([0,1]\.\d{2}$)/) {
			$cfe = $1 * 100;
		} else {
			$cfe = "";
		}
		# Grid carbon intensity (gCO2eq/kWh)
		if ($co2_kwh =~ /^(\d+(\.\d+)?)$/) {
			$co2_kwh = $1;
		} else {
			$co2_kwh = "";
		}
		# https://cloud.google.com/sustainability/region-carbon#region-picker
		# 18.12.2025: https://archive.is/HKHtV
		# For a location to be considered "low carbon",
		# it must belong to a region with a Google CFE% of at least 75%,
		my $low_co2 = "0";
		if ($cfe >= "75") {
			$low_co2 = "1";
		# or, if CFE% information is not available,
		# a grid carbon intensity of maximum 200 gCO2eq/kWh.
		} elsif (!$cfe && $co2_kwh <= "200") {
			$low_co2 = "1";
		}
		print "UPDATE instances SET regionCfe = '$cfe', regionCo2Kwh = '$co2_kwh', regionLowCo2 = '$low_co2' WHERE region = '$region';\n";
	}
}
$dbh->disconnect;