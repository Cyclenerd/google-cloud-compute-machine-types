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
# Create static website with all GCE machines in regions
#

use utf8;
use strict;
use DBI;
use JSON::XS;
use Template;
use File::Copy;
use App::Options (
	option => {
		instance_in_region => {
			required    => '1',
			default     => '1',
			description => "Create instance in region websites (/:REGION/:INSTANCE.html)"
		},
		limit_region => {
			required    => '0',
			default     => '',
			description => "Create websites only for this region"
		},
	},
);

my $create_instance_in_region   = $App::options{instance_in_region};
my $create_instance_vs_instance = $App::options{instance_vs_instance};
my $limit_region                = $App::options{limit_region};
my $db_file  = 'gce.db';

my $gmttime   = gmtime();
my $timestamp = time();

my $dbh = DBI->connect("dbi:SQLite:dbname=$db_file","","") or die "ERROR: Cannot connect $DBI::errstr\n";

my $template = Template->new(
	INCLUDE_PATH => './src',
	VARIABLES => {
		'gmttime'   => $gmttime,
		'timestamp' => $timestamp
	}
);
my @files = ();

my $sql_instances = qq ~
SELECT
	UPPER(series) AS series, name, description, family,
	vCpus, LOWER(sharedCpu) AS sharedCpu, intel, amd, cpuPlatform, cpuBaseClock, cpuTurboClock, cpuSingleMaxTurboClock,
	coremarkScore, standardDeviation, sampleCount,
	memoryGiB,
	bandwidth, tier1,
	disks, disksSizeGb/1024 AS diskSizeTiB, localSsd,
	acceleratorCount, acceleratorType,
	sap, saps, hana,
	spot,
	COUNT(region) AS regionCount,
	(SELECT GROUP_CONCAT(region) FROM instances WHERE name LIKE I.name ORDER BY region) AS regions,
	sud,
	ROUND(MIN(hour), 4)         AS minHour,       ROUND(AVG(hour), 4)       AS avgHour,       ROUND(MAX(hour), 4)       AS maxHour,
	ROUND(MIN(month), 2)        AS minMonth,      ROUND(AVG(month), 2)      AS avgMonth,      ROUND(MAX(month), 2)      AS maxMonth,
	ROUND(MIN(month1yCud), 2)   AS minMonth1yCud, ROUND(AVG(month1yCud), 2) AS avgMonth1yCud, ROUND(MAX(month1yCud), 2) AS maxMonth1yCud,
	ROUND(MIN(month3yCud), 2)   AS minMonth3yCud, ROUND(AVG(month3yCud), 2) AS avgMonth3yCud, ROUND(MAX(month3yCud), 2) AS maxMonth3yCud,
	ROUND(monthSles, 2)         AS monthSles,
	ROUND(monthSlesSap, 2)      AS monthSlesSap,
	ROUND(monthSlesSap1yCud, 2) AS monthSlesSap1yCud,
	ROUND(monthSlesSap3yCud, 2) AS monthSlesSap3yCud,
	ROUND(monthRhel, 2)         AS monthRhel,
	ROUND(monthRhelSap, 2)      AS monthRhelSap,
	ROUND(monthWindows, 2)      AS monthWindows
FROM instances I
GROUP BY name
ORDER BY vCpus, name
~;
my $sth = $dbh->prepare($sql_instances);
$sth->execute();
my @instances = ();
my $id = '1';
while (my $instance = $sth->fetchrow_hashref) {
	$instance->{'id'} = $id;
	push(@instances, $instance);
	$id++;
}
$sth->finish;
push(@files, 'instances.html');
$template->process('instances.tt2', { 'instances' => \@instances }, '../site/instances.html') || die "Template process failed: ", $template->error(), "\n";

my $sql_regions = qq ~
SELECT
	region AS name,
	regionLocation,
	MAX(zoneCount) AS zoneCount,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "a2")  AS a2,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "c2")  AS c2,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "c2d") AS c2d,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "e2")  AS e2,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "m1")  AS m1,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "m2")  AS m2,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "n1")  AS n1,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "n2")  AS n2,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "n2d") AS n2d,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "t2d") AS t2d,
	(SELECT MIN(hour)   FROM instances WHERE region LIKE I.region AND name   LIKE "e2-standard-8") AS e2Standard8Hour,
	(SELECT MIN(month)  FROM instances WHERE region LIKE I.region AND name   LIKE "e2-standard-8") AS e2Standard8Month
FROM instances I
GROUP BY region
ORDER BY region
~;
$sth = $dbh->prepare($sql_regions);
$sth->execute();
my @regions = ();
$id = '1';
while (my $region = $sth->fetchrow_hashref) {
	$region->{'id'} = $id;
	push(@regions, $region);
	$id++;
}
$sth->finish;
push(@files, 'regions.html');
$template->process('regions.tt2', { 'regions' => \@regions }, '../site/regions.html') || die "Template process failed: ", $template->error(), "\n";

foreach my $region (@regions) {
	my $name = $region->{'name'} || 'missing';
	my $sql_instances_in_region = qq ~
		SELECT
			UPPER(series) AS series, name, description, family,
			vCpus, LOWER(sharedCpu) AS sharedCpu, cpuBaseClock,
			memoryGiB,
			zoneCount,
			ROUND(hour, 4)              AS hour,
			ROUND(month, 2)             AS month,
			ROUND(month1yCud, 2)        AS month1yCud,
			ROUND(month3yCud, 2)        AS month3yCud,
			ROUND(monthSles, 2)         AS monthSles,
			ROUND(monthSlesSap, 2)      AS monthSlesSap,
			ROUND(monthSlesSap1yCud, 2) AS monthSlesSap1yCud,
			ROUND(monthSlesSap3yCud, 2) AS monthSlesSap3yCud,
			ROUND(monthRhel, 2)         AS monthRhel,
			ROUND(monthRhelSap, 2)      AS monthRhelSap,
			ROUND(monthWindows, 2)      AS monthWindows
		FROM instances
		WHERE region LIKE '$name'
		ORDER BY vCpus, name;
	~;
	$sth = $dbh->prepare($sql_instances_in_region);
	$sth->execute();
	my @instances = ();
	$id = '1';
	while (my $instance = $sth->fetchrow_hashref) {
		$instance->{'id'} = $id;
		push(@instances, $instance);
		$id++;
	}
	my $html_file = '../site/'."$name".'.html';
	print "$html_file\n";
	push(@files, "$name".'.html');
	$template->process('region.tt2', { 'region' => $region, 'instances' => \@instances }, "$html_file") || die "Template process failed: ", $template->error(), "\n";
}

foreach my $instance (@instances) {
	my $name = $instance->{'name'} || 'missing';
	my $sql_instance_regions = qq ~
		SELECT
			region                      AS name,
			regionLocation,
			ROUND(hour, 4)              AS hour,
			ROUND(month, 2)             AS month,
			ROUND(month1yCud, 2)        AS month1yCud,
			ROUND(month3yCud, 2)        AS month3yCud,
			ROUND(monthSles, 2)         AS monthSles,
			ROUND(monthSlesSap, 2)      AS monthSlesSap,
			ROUND(monthSlesSap1yCud, 2) AS monthSlesSap1yCud,
			ROUND(monthSlesSap3yCud, 2) AS monthSlesSap3yCud,
			ROUND(monthRhel, 2)         AS monthRhel,
			ROUND(monthRhelSap, 2)      AS monthRhelSap,
			ROUND(monthWindows, 2)      AS monthWindows
		FROM instances
		WHERE name LIKE '$name'
		ORDER BY hour, region;
	~;
	$sth = $dbh->prepare($sql_instance_regions);
	$sth->execute();
	my @regions = ();
	$id = '1';
	while (my $region = $sth->fetchrow_hashref) {
		$region->{'id'} = $id;
		push(@regions, $region);
		$id++;
	}
	$sth->finish;
	my $html_file = '../site/'."$name".'.html';
	print "$html_file\n";
	push(@files, "$name".'.html');
	$template->process('instance.tt2', { 'instance' => $instance, 'regions' => \@regions }, "$html_file") || die "Template process failed: ", $template->error(), "\n";
}

my $sql_instance_in_region = qq ~
SELECT
	UPPER(series) AS series, name, description, family,
	vCpus, LOWER(sharedCpu) AS sharedCpu, intel, amd, cpuPlatform, cpuBaseClock, cpuTurboClock, cpuSingleMaxTurboClock,
	coremarkScore, standardDeviation, sampleCount,
	memoryGiB,
	bandwidth, tier1,
	disks, disksSizeGb/1024 AS diskSizeTiB, localSsd,
	acceleratorCount, acceleratorType,
	sap, saps, hana,
	spot,
	region, regionLocation, zoneCount, zones,
	sud,
	ROUND(hour, 4)              AS hour,
	ROUND(month, 2)             AS month,
	ROUND(month1yCud, 2)        AS month1yCud,
	ROUND(month3yCud, 2)        AS month3yCud,
	ROUND(monthSles, 2)         AS monthSles,
	ROUND(monthSlesSap, 2)      AS monthSlesSap,
	ROUND(monthSlesSap1yCud, 2) AS monthSlesSap1yCud,
	ROUND(monthSlesSap3yCud, 2) AS monthSlesSap3yCud,
	ROUND(monthRhel, 2)         AS monthRhel,
	ROUND(monthRhelSap, 2)      AS monthRhelSap,
	ROUND(monthWindows, 2)      AS monthWindows
FROM instances
ORDER BY name, region
~;
my $sth = $dbh->prepare($sql_instance_in_region);
$sth->execute();
my @instances_in_regions = ();
my $id = '1';
while (my $instance = $sth->fetchrow_hashref) {
	my $name   = $instance->{'name'}   || 'missing';
	my $region = $instance->{'region'} || 'missing';
	next if ($limit_region && $limit_region ne "$region"); # skip region if limit is set
	$instance->{'id'} = $id;
	push(@instances_in_regions, $instance);
	if ($create_instance_in_region) {
		my $html_file = '../site/'."$region/$name".'.html';
		print "$id : $html_file\n";
		push(@files, "$region/$name".'.html');
		$template->process('instance_in_region.tt2', {
			'gmttime'  => $gmttime,
			'instance' => $instance,
			'regions'  => \@regions
		}, "$html_file") || die "Template process failed: ", $template->error(), "\n";
	}
	$id++;
}
$sth->finish;

# Index
$template->process('index.tt2', {
	'instances'            => \@instances,
	'regions'              => \@regions,
	'instances_in_regions' => \@instances_in_regions
}, '../site/index.html') || die "Template process failed: ", $template->error(), "\n";

# Sitemap
$template->process('sitemap.tt2', { 'files' => \@files }, '../site/sitemap.txt') || die "Template process failed: ", $template->error(), "\n";

# 404
$template->process('404.tt2', {}, '../site/404.html') || die "Template process failed: ", $template->error(), "\n";

# Robots.txt
$template->process('robots.txt', {}, '../site/robots.txt')     || die "Template process failed: ", $template->error(), "\n";

# Grid
$template->process('main.js', {}, '../site/main.js')     || die "Template process failed: ", $template->error(), "\n";
$template->process('grid.html', {}, '../site/grid.html') || die "Template process failed: ", $template->error(), "\n";
open(FH, '>', '../site/instance_in_region.json') or die $!;
print FH encode_json \@instances_in_regions;
close FH;

# Images
mkdir(                                '../site/img/');
copy( './src/img/combine-filter.png', '../site/img/combine-filter.png');
copy( './src/img/filter.png',         '../site/img/filter.png');
copy( './src/img/show-more.png',      '../site/img/show-more.png');
copy( './src/img/sort.png',           '../site/img/sort.png');
copy( './src/img/spreadsheet.png',    '../site/img/spreadsheet.png');
copy( './src/favicon.ico',            '../site/favicon.ico');