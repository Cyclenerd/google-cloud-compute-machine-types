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

use strict;
use DBI;

my $dbh = DBI->connect("dbi:CSV:", undef, undef, {
	f_ext        => ".csv/r",
	csv_sep_char => ";",
	csv_class    => "Text::CSV_XS",
	RaiseError   => 1,
}) or die "ERROR: Cannot connect $DBI::errstr\n";

my $sth = $dbh->prepare("SELECT MACHINE_TYPE, COREMARK_SCORE, STANDARD_DEVIATION, SAMPLE_COUNT FROM coremark");
$sth->execute();
$sth->bind_columns(\my ($name, $coremarkScore, $standardDeviation, $sampleCount));
print "/*\n";
print " * GENERATED WITH coremark.pl\n";
print " * Please see: https://github.com/Cyclenerd/google-cloud-compute-machine-types/blob/master/instances/series/cpu/README.md\n";
print " */\n";
while ($sth->fetch) {
	if ($name) {
		$name =~ s/^\s//;
		$name =~ s/\s$//;
		$coremarkScore =~ s/,//g;
		$coremarkScore =~ s/\s//g;
		$sampleCount   =~ s/,//g;
		$sampleCount   =~ s/\s//g;
		print "UPDATE instances SET coremarkScore = '$coremarkScore', standardDeviation = '$standardDeviation', sampleCount = '$sampleCount' WHERE name LIKE '$name';\n";
	}
}
$dbh->disconnect;