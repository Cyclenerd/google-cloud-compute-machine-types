#!/usr/bin/env perl

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

use utf8;
binmode(STDOUT, ':encoding(utf8)');
use strict;
use JSON::XS;

open(FH, "regions.json") or die "JSON file 'regions.json' can't be opened";
my $json = "";
while(<FH>){
   $json .= $_;
}
close(FH);
my $regions = JSON::XS->new->utf8->decode($json);

print "/*\n";
print " * GENERATED WITH regions.pl\n";
print " * Please see: https://github.com/Cyclenerd/google-cloud-compute-machine-types/blob/master/regions/README.md\n";
print " */\n";

my @names = keys %$regions;
foreach my $name (sort @names) {
	my $location_name = $regions->{$name}->{'name'};
	$location_name =~ s/'/''/g; # Escape single quotes for SQL
	print "UPDATE instances SET regionLocationLong = '". $location_name ."', regionLat = '". $regions->{$name}->{'latitude'} ."', regionLng = '". $regions->{$name}->{'longitude'} ."' WHERE region = '". $name ."';\n";
}
