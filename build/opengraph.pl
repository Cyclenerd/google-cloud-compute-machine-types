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
# Create Open Graph images (https://ogp.me/) for all GCE machines in all regions
#

use utf8;
binmode(STDOUT, ':encoding(utf8)');
use strict;
use DBI;
use Encode qw(decode);
use GD::Simple; # libgd-perl
use File::Copy;
use App::Options (
	option => {
		region => {
			required    => '1',
			default     => '1',
			description => "Create images for instances in region (/:REGION/:INSTANCE.png)"
		},
		limit_region => {
			required    => '0',
			default     => '',
			description => "Create images only for this region"
		},
		comparison => {
			required    => '1',
			default     => '1',
			description => "Create images for instance comparison (/:INSTANCE_A/:INSTANCE_B.png)"
		},
		limit_comparison => {
			required    => '0',
			default     => '',
			description => "Create images only for this machine type"
		},
	},
);

my $create_region     = $App::options{region};
my $limit_region      = $App::options{limit_region};
my $create_comparison = $App::options{comparison};
my $limit_comparison  = $App::options{limit_comparison};

my $db_file  = 'gce.db';
my $dbh = DBI->connect("dbi:SQLite:dbname=$db_file","","") or die "ERROR: Cannot connect $DBI::errstr\n";

my $dir = '../opengraph/';
unless (-d "$dir") {
	mkdir("$dir") or die "Can not create dir for opengraph images!\n";
}


###############################################################################
# IMAGE TEMPLATE
###############################################################################

my $left  = '80';

sub image {
	# create a new image
	my $img = GD::Simple->new('1200', '600');
	#my $img = GD::Simple->newFromJpeg('social.jpg', 1);

	# red:    #dc3545
	#         220,53,69
	# blue:   #0d6efd
	#         13,110,253
	# green:  #198754
	#         25,135,84
	# yellow: #ffc107
	#         255,193,7
	# gray:   #adb5bd
	#         173,181,189

	# red
	$img->bgcolor(220,53,69);
	$img->fgcolor(220,53,69);
	$img->rectangle(0,0,1200,60);

	# blue
	$img->bgcolor(13,110,253);
	$img->fgcolor(13,110,253);
	$img->rectangle(1140,0,1200,600);

	# green
	$img->bgcolor(25,135,84);
	$img->fgcolor(25,135,84);
	$img->rectangle(0,540,1200,600);

	# yellow
	$img->bgcolor(255,193,7);
	$img->fgcolor(255,193,7);
	$img->rectangle(0,61,60,600);

	# Font
	$img->font('Roboto'); # fonts-roboto

	# Link
	$img->bgcolor(173,181,189);
	$img->fgcolor(173,181,189);
	$img->moveTo( 400, 520 );
	$img->fontsize('40');
	$img->string('https://gcloud-compute.com/');

	# Black
	$img->bgcolor('black');
	$img->fgcolor('black');

	return $img;
}

###############################################################################
# INSTANCES
###############################################################################

my $sql_instances = qq ~
SELECT
	name,
	vCpus,
	LOWER(sharedCpu) AS sharedCpu,
	MAX(cpuBaseClock) AS cpuBaseClock,
	memoryGiB
FROM instances
GROUP BY name
ORDER BY name
~;
my $sth = $dbh->prepare($sql_instances);
$sth->execute();
my @instances = ();
while (my $instance = $sth->fetchrow_hashref) {
	push(@instances, $instance);
}

###############################################################################
# REGIONS
###############################################################################

my $sql_regions = qq ~
SELECT
	region AS name,
	regionLocation
FROM instances
GROUP BY region
ORDER BY region
~;
$sth = $dbh->prepare($sql_regions);
$sth->execute();
my @regions = ();
while (my $region = $sth->fetchrow_hashref) {
	push(@regions, $region);
}


###############################################################################
# IMAGES
###############################################################################

# social.png
my $social = image();
# Small title
$social->moveTo($left, 100);
$social->fontsize('20');
$social->string('Google Cloud Platfrom VMs');
# Machine types
$social->moveTo( $left, 190 );
$social->fontsize('60');
$social->string("Google Compute Engine");
# Text
$social->moveTo( $left, 270 );
$social->fontsize('40');
$social->string("GCE machine type comparison");
# Save
open(FH, '>', "$dir/social.png") or die $!;
binmode FH;
print FH $social->png('8');
close(FH);

# grid.png
my $grid = image();
# Small title
$grid->moveTo($left, 100);
$grid->fontsize('20');
$grid->string('Google Compute Engine machine types');
# Machine types
$grid->moveTo( $left, 190 );
$grid->fontsize('60');
$grid->string("Instance Picker");
# Text
$grid->moveTo( $left, 270 );
$grid->fontsize('40');
$grid->string("GCE machine type comparison");
# Save
open(FH, '>', "$dir/grid.png") or die $!;
binmode FH;
print FH $grid->png('8');
close(FH);

# instances.png
my $instances = image();
# Small title
$instances->moveTo($left, 100);
$instances->fontsize('20');
$instances->string('Google Compute Engine');
# Machine types
$instances->moveTo( $left, 190 );
$instances->fontsize('60');
$instances->string("Machine types");
# Save
open(FH, '>', "$dir/instances.png") or die $!;
binmode FH;
print FH $instances->png('8');
close(FH);

# regions.png
my $regions = image();
# Small title
$regions->moveTo($left, 100);
$regions->fontsize('20');
$regions->string('Google Cloud');
# Regions
$regions->moveTo( $left, 190 );
$regions->fontsize('60');
$regions->string("Regions");
# Save
open(FH, '>', "$dir/regions.png") or die $!;
binmode FH;
print FH $regions->png('8');
close(FH);

# Regions
if ($create_region) {
	foreach my $region (@regions) {
		my $region_name     = $region->{'name'}           || 'missing';
		my $region_location = $region->{'regionLocation'} || '';
		next if ($limit_region && $limit_region ne "$region_name"); # skip region if limit is set
		my $img = image();
		print "$region_name\n";
		# Small title
		$img->moveTo($left, 100);
		$img->fontsize('20');
		$img->string('Google Cloud region:');
		# Region
		$img->moveTo( $left, 190 );
		$img->fontsize('60');
		$img->string("$region_name");
		# Location
		if ($region_location) {
			$img->moveTo( $left, 270 );
			$img->fontsize('40');
			$img->string("Location: $region_location");
		}
		# Save
		open(FH, '>', "$dir/$region_name.png") or die $!;
		binmode FH;
		print FH $img->png('8');
		close(FH);
		# Create dir for instances in region
		unless (-d "$dir/$region_name/") {
			mkdir("$dir/$region_name/") or die "Can not create dir for region '$region_name'!\n";
		}
	}
}

# Instances
foreach my $instance (@instances) {
	my $name           = $instance->{'name'}         || 'missing';
	my $cpu_count      = $instance->{'vCpus'}        || '0';
	my $cpu_shared     = $instance->{'sharedCpu'}    || '0';
	my $cpu_base_clock = $instance->{'cpuBaseClock'} || '0';
	my $ram            = $instance->{'memoryGiB'}    || '0';
	my $img = image();
	print "$name\n";
	# Small title
	$img->moveTo($left, 100);
	$img->fontsize('20');
	$img->string('Google Compute Engine machine type:');
	# Machine type
	$img->moveTo( $left, 190 );
	$img->fontsize('60');
	$img->string("$name");
	# vCPU
	$img->moveTo( $left, 270 );
	$img->fontsize('40');
	my $cpu_text  = "vCPU: $cpu_count";
	   $cpu_text .= " ($cpu_base_clock GHz)" if ($cpu_base_clock > 0);
	   $cpu_text .= ' [Shared]' if ($cpu_shared > 0);
	$img->string("$cpu_text");
	# Memory
	$img->moveTo( $left, 350 );
	$img->fontsize('40');
	$img->string("Memory: $ram GB");
	# Save
	open(FH, '>', "$dir/$name.png") or die $!;
	binmode FH;
	print FH $img->png('8');
	close(FH);
	# Create dir for comparison
	unless (-d "$dir/$name/") {
		mkdir("$dir/$name/") or die "Can not create dir for machine type '$name'!\n";
	}
	# Machine type in region
	if ($create_region) {
		foreach my $region (@regions) {
			my $region_name = $region->{'name'} || 'missing';
			print "\t $region_name\n";
			next if ($limit_region && $limit_region ne "$region_name"); # skip region if limit is set
			# Region
			$img->bgcolor('white');
			$img->fgcolor('white');
			$img->rectangle($left,420,1130,450);
			$img->bgcolor('black');
			$img->fgcolor('black');
			$img->moveTo( $left, 430 );
			$img->fontsize('40');
			$img->string("Region: $region_name");
			# Save
			open(FH, '>', "$dir/$region_name/$name.png") or die $!;
			binmode FH;
			print FH $img->png('8');
			close(FH);
		}
	}
}

# Comparison
if ($create_comparison) {
	foreach my $instance (@instances) {
		my $name           = $instance->{'name'}         || 'missing';
		my $cpu_count      = $instance->{'vCpus'}        || '0';
		my $cpu_shared     = $instance->{'sharedCpu'}    || '0';
		my $cpu_base_clock = $instance->{'cpuBaseClock'} || '0';
		my $ram            = $instance->{'memoryGiB'}    || '0';
		next if ($limit_comparison && $limit_comparison ne "$limit_comparison"); # skip instance if limit is set
		foreach my $instance_b (@instances) {
			my $name_b           = $instance_b->{'name'}         || 'missing';
			my $cpu_count_b      = $instance_b->{'vCpus'}        || '0';
			my $cpu_shared_b     = $instance_b->{'sharedCpu'}    || '0';
			my $cpu_base_clock_b = $instance_b->{'cpuBaseClock'} || '0';
			my $ram_b            = $instance_b->{'memoryGiB'}    || '0';
			next if $name eq $name_b;
			my $img = image();
			print "$name vs $name_b\n";
			# Small title
			$img->moveTo($left, 100);
			$img->fontsize('20');
			$img->string('Google Compute Engine machine type comparison:');

			# Machine type A
			$img->moveTo( $left, 190 );
			$img->fontsize('60');
			$img->string("$name");
			# Short info text
			my $text  = "$cpu_count vCPU";
			   $text .= " ($cpu_base_clock GHz)" if ($cpu_base_clock > 0);
			   $text .= ' [Shared]' if ($cpu_shared > 0);
			   $text .= ", $ram GB RAM";
			$img->moveTo( $left, 250 );
			$img->fontsize('40');
			$img->string("$text");

			# Vs
			$img->moveTo( $left, 305 );
			$img->fontsize('20');
			$img->string('versus');

			# Machine type B
			$img->moveTo( $left, 400 );
			$img->fontsize('60');
			$img->string("$name_b");
			# Short info text
			my $text_b  = "$cpu_count_b vCPU";
			   $text_b .= " ($cpu_base_clock_b GHz)" if ($cpu_base_clock_b > 0);
			   $text_b .= ' [Shared]' if ($cpu_shared_b > 0);
			   $text_b .= ", $ram_b GB RAM";

			$img->moveTo( $left, 460 );
			$img->fontsize('40');
			$img->string("$text_b");

			# Save
			open(FH, '>', "$dir/$name/$name_b.png") or die $!;
			binmode FH;
			print FH $img->png('8');
			close(FH);
		}
	}
}