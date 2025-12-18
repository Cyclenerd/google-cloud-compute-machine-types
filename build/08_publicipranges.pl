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
# Calculate public IP addresses
# Thank you PatMyron: https://github.com/PatMyron/cloud/issues/11#issuecomment-922591282
#

use utf8;
binmode(STDOUT, ':encoding(utf8)');
use strict;
use JSON::XS;

open(FH, "publicipranges.json") or die "JSON file 'publicipranges.json' can't be opened";
my $json = "";
while(<FH>){
	$json .= $_;
}
close(FH);
my $publicipranges = JSON::XS->new->utf8->decode($json);

my %regions;
my $total = "0";
foreach my $prefix (sort @{$publicipranges->{'prefixes'}}) {
	my $name = $prefix->{'scope'};
	if ($prefix->{'ipv4Prefix'} =~ /\/(\d+)$/) {
		my $mask = $1;
		my $ipv4 = 2**(32-$mask);
		$regions{$name} += $ipv4;
		$total += $ipv4;
	}
}

foreach my $region (sort keys %regions) {
	my $ipv4 = $regions{$region} || "0.0";
	print "UPDATE instances SET regionPublicIpv4Addr = '$ipv4' WHERE region LIKE '$region';\n";
}