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
binmode(STDOUT, ':encoding(utf8)');
use strict;
use DBI;
use Encode qw(decode);
use JSON::XS;
use Template;
use File::Copy;
use App::Options (
	option => {
		region => {
			required    => '1',
			default     => '1',
			description => "Create instance in region websites (/:REGION/:INSTANCE.html)"
		},
		limit_region => {
			required    => '0',
			default     => '',
			description => "Create websites only for this region"
		},
		comparison => {
			required    => '1',
			default     => '1',
			description => "Create instance comparison websites (/comparison/:INSTANCE/vs/:INSTANCE.html)"
		},
		limit_comparison => {
			required    => '0',
			default     => '',
			description => "Create comparison websites only for this machine type"
		},
	},
);

my $create_region     = $App::options{region};
my $limit_region      = $App::options{limit_region};
my $create_comparison = $App::options{comparison};
my $limit_comparison  = $App::options{limit_comparison};

my $db_file  = 'gce.db';

my $gmttime   = gmtime();
my $timestamp = time();

# Exports
my $csv_export = 'machine-types-regions.csv';
my $sql_export = 'machine-types-regions.sql.gz';
my $filesize_csv_export = -s "$csv_export" || die "ERROR: Cannot get CSV '$csv_export' filesize!\n";
my $filesize_sql_export = -s "$sql_export" || die "ERROR: Cannot get SQL '$sql_export' filesize!\n";
# MiB
$filesize_csv_export = sprintf '%.2f', $filesize_csv_export / 1048576;
$filesize_sql_export = sprintf '%.2f', $filesize_sql_export / 1048576;

print "Create websites...\n";

my $dbh = DBI->connect("dbi:SQLite:dbname=$db_file","","") or die "ERROR: Cannot connect $DBI::errstr\n";

my $template = Template->new(
	INCLUDE_PATH => './src',
	PRE_PROCESS  => 'config.tt2',
	VARIABLES => {
		'gmttime'          => $gmttime,
		'timestamp'        => $timestamp,
		'gitHubServerUrl'  => $ENV{'GITHUB_SERVER_URL'} || '',
		'gitHubRepository' => $ENV{'GITHUB_REPOSITORY'} || '',
		'gitHubRunId'      => $ENV{'GITHUB_RUN_ID'}     || '',
	}
);
my @files = ();


###############################################################################
# INSTANCES
###############################################################################

my $sql_instances = qq ~
SELECT
	UPPER(series) AS series, name, description, family,
	vCpus, LOWER(sharedCpu) AS sharedCpu,
	MAX(intel) AS intel,
	MAX(amd) AS amd,
	MAX(arm) AS arm,
	MAX(cpuPlatformCount) AS cpuPlatformCount,
	(SELECT cpuPlatform FROM instances WHERE name LIKE I.name ORDER BY cpuPlatformCount) AS cpuPlatform,
	MAX(cpuBaseClock) AS cpuBaseClock, MAX(cpuTurboClock) AS cpuTurboClock, MAX(cpuSingleMaxTurboClock) AS cpuSingleMaxTurboClock,
	MAX(coremarkScore) AS coremarkScore, MAX(standardDeviation) AS standardDeviation, MAX(sampleCount) AS sampleCount,
	memoryGiB,
	bandwidth, tier1,
	disks, disksSizeGb/1024 AS diskSizeTiB, localSsd,
	acceleratorCount, acceleratorType,
	MAX(sap) AS sap, MAX(saps) AS saps, MAX(hana) AS hana,
	MAX(spot) AS spot,
	COUNT(region) AS regionCount,
	(SELECT GROUP_CONCAT(region) FROM instances WHERE name LIKE I.name ORDER BY region) AS regions,
	MAX(sud) AS sud,
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

# CPU
push(@files, 'intel.html');
$template->process('intel.tt2', { 'instances' => \@instances }, '../site/intel.html') || die "Template process failed: ", $template->error(), "\n";
push(@files, 'amd.html');
$template->process('amd.tt2', { 'instances' => \@instances }, '../site/amd.html') || die "Template process failed: ", $template->error(), "\n";
push(@files, 'arm.html');
$template->process('arm.tt2', { 'instances' => \@instances }, '../site/arm.html') || die "Template process failed: ", $template->error(), "\n";
# SAP
push(@files, 'sap.html');
$template->process('sap.tt2', { 'instances' => \@instances }, '../site/sap.html') || die "Template process failed: ", $template->error(), "\n";
push(@files, 'hana.html');
$template->process('hana.tt2', { 'instances' => \@instances }, '../site/hana.html') || die "Template process failed: ", $template->error(), "\n";

###############################################################################
# DISKS
###############################################################################

my $sql_disks = qq ~
SELECT
	name,
	description,
	COUNT(region) AS regionCount,
	ROUND(MIN(monthGb), 2) AS minMonth,
	ROUND(AVG(monthGb), 2) AS avgMonth,
	ROUND(MAX(monthGb), 2) AS maxMonth
FROM disks D
GROUP BY name
ORDER BY name
~;
$sth = $dbh->prepare($sql_disks);
$sth->execute();
my @disks = ();
$id = '1';
while (my $disk = $sth->fetchrow_hashref) {
	$disk->{'id'} = $id;
	push(@disks, $disk);
	$id++;
}
$sth->finish;
push(@files, 'disks.html');
$template->process('disks.tt2', { 'disks' => \@disks }, '../site/disks.html') || die "Template process failed: ", $template->error(), "\n";
$template->process('disks.js', {}, '../site/disks.js') || die "Template process failed: ", $template->error(), "\n";


###############################################################################
# DISKS in REGIONS
###############################################################################

my $sql_disks_regions = qq ~
SELECT
	region          AS name,
	regionLocation  AS regionLocation,
	MAX(zoneCount)  AS zoneCount,
	(SELECT ROUND(MAX(monthGb), 3) FROM disks WHERE region LIKE D.region AND name LIKE "local-ssd")   AS local,
	(SELECT ROUND(MAX(monthGb), 3) FROM disks WHERE region LIKE D.region AND name LIKE "pd-balanced") AS balanced,
	(SELECT ROUND(MAX(monthGb), 3) FROM disks WHERE region LIKE D.region AND name LIKE "pd-extreme")  AS extreme,
	(SELECT ROUND(MAX(monthGb), 3) FROM disks WHERE region LIKE D.region AND name LIKE "pd-ssd")      AS ssd,
	(SELECT ROUND(MAX(monthGb), 3) FROM disks WHERE region LIKE D.region AND name LIKE "pd-standard") AS standard
FROM disks D
GROUP BY region
ORDER BY region
~;
$sth = $dbh->prepare($sql_disks_regions);
$sth->execute();
my @disks_regions = ();
while (my $region = $sth->fetchrow_hashref) {
	push(@disks_regions, $region);
}
$sth->finish;
# Regions
push(@files, 'diskpricing.html');
$template->process('diskpricing.tt2', { 'disks_regions' => \@disks_regions }, '../site/diskpricing.html') || die "Template process failed: ", $template->error(), "\n";


###############################################################################
# REGIONS
###############################################################################

my $sql_regions = qq ~
SELECT
	region                    AS name,
	regionLocation            AS regionLocation,
	regionLocationLong        AS regionLocationLong,
	regionLocationCountryCode AS regionLocationCountryCode,
	regionCfe                 AS regionCfe,
	regionCo2Kwh              AS regionCo2Kwh,
	regionLowCo2              AS regionLowCo2,
	regionLat                 AS regionLat,
	regionLng                 AS regionLng,
	MAX(regionPublicIpv4Addr) AS regionPublicIpv4Addr,
	MAX(zoneCount)            AS zoneCount,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND availableCpuPlatform LIKE "%Sandy%")        AS intelSandy,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND availableCpuPlatform LIKE "%Ivy%")          AS intelIvy,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND availableCpuPlatform LIKE "%Haswell%")      AS intelHaswell,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND availableCpuPlatform LIKE "%Broadwell%")    AS intelBroadwell,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND availableCpuPlatform LIKE "%Skylake%")      AS intelSkylake,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND availableCpuPlatform LIKE "%Cascade Lake%") AS intelCascadeLake,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND availableCpuPlatform LIKE "%Ice Lake%")     AS intelIceLake,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND availableCpuPlatform LIKE "%Rome%")         AS amdRome,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND availableCpuPlatform LIKE "%Milan%")        AS amdMilan,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND availableCpuPlatform LIKE "%Altra%")        AS armAmpereAltra,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "a2")  AS a2,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "c2")  AS c2,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "c2d") AS c2d,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "e2")  AS e2,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "m1")  AS m1,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "m2")  AS m2,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "m3")  AS m3,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "n1")  AS n1,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "n2")  AS n2,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "n2d") AS n2d,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "t2d") AS t2d,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND series LIKE "t2a") AS t2a,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND sap >= 1) AS sap,
	(SELECT COUNT(name) FROM instances WHERE region LIKE I.region AND hana >= 1) AS hana,
	(SELECT ROUND(MIN(hour), 4)  FROM instances WHERE region LIKE I.region AND name LIKE "e2-standard-8") AS e2Standard8Hour,
	(SELECT ROUND(MIN(month), 2) FROM instances WHERE region LIKE I.region AND name LIKE "e2-standard-8") AS e2Standard8Month
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
# Regions
push(@files, 'regions.html');
$template->process('regions.tt2', { 'regions' => \@regions }, '../site/regions.html') || die "Template process failed: ", $template->error(), "\n";
# Map with regions
push(@files, 'map.html');
$template->process('map.tt2', { 'regions' => \@regions }, '../site/map.html') || die "Template process failed: ", $template->error(), "\n";
# CPU platforms in regions
push(@files, 'platforms.html');
$template->process('platforms.tt2', { 'regions' => \@regions }, '../site/platforms.html') || die "Template process failed: ", $template->error(), "\n";


###############################################################################
# REGION
###############################################################################

# Instances in Region
foreach my $region (@regions) {
	my $name = $region->{'name'} || 'missing';
	# Instances
	my $sql_instances_in_region = qq ~
		SELECT
			UPPER(series) AS series, name, description, family,
			vCpus, LOWER(sharedCpu) AS sharedCpu, 
			intel, amd, arm, availableCpuPlatformCount, cpuPlatformCount,
			cpuBaseClock, cpuTurboClock, cpuSingleMaxTurboClock,
			memoryGiB,
			sap, saps, hana,
			zoneCount,
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
		WHERE region LIKE '$name'
		ORDER BY vCpus, name;
	~;
	$sth = $dbh->prepare($sql_instances_in_region);
	$sth->execute();
	my @instances_in_region = ();
	$id = '1';
	while (my $instance = $sth->fetchrow_hashref) {
		$instance->{'id'} = $id;
		push(@instances_in_region, $instance);
		$id++;
	}
	# Disks
	my $sql_disks_in_region = qq ~
		SELECT
			name,
			description,
			zoneCount,
			monthGb
		FROM disks
		WHERE region LIKE '$name'
		ORDER BY name;
	~;
	$sth = $dbh->prepare($sql_disks_in_region);
	$sth->execute();
	my @disks_in_region = ();
	$id = '1';
	while (my $disk = $sth->fetchrow_hashref) {
		$disk->{'id'} = $id;
		push(@disks_in_region, $disk);
		$id++;
	}
	my $html_file = '../site/'."$name".'.html';
	print "$html_file\n";
	push(@files, "$name".'.html');
	$template->process('region.tt2', {
		'region'              => $region,
		'regions'             => \@regions,
		'instances'           => \@instances,
		'disks_in_region'     => \@disks_in_region,
		'instances_in_region' => \@instances_in_region
	}, "$html_file") || die "Template process failed: ", $template->error(), "\n";
}


###############################################################################
# INSTANCE
###############################################################################

# Instance in Regions
foreach my $instance (@instances) {
	my $name = $instance->{'name'} || 'missing';
	my $sql_instance_regions = qq ~
		SELECT
			region                         AS name,
			regionLocation                 AS regionLocation,
			regionCfe                      AS regionCfe,
			regionCo2Kwh                   AS regionCo2Kwh,
			regionLowCo2                   AS regionLowCo2,
			zoneCount                      AS zoneCount,
			availableCpuPlatformCount      AS availableCpuPlatformCount,
			ROUND(hour, 4)                 AS hour,
			ROUND(month, 2)                AS month,
			ROUND(month1yCud, 2)           AS month1yCud,
			ROUND(month3yCud, 2)           AS month3yCud,
			ROUND(monthSles, 2)            AS monthSles,
			ROUND(monthSlesSap, 2)         AS monthSlesSap,
			ROUND(monthSlesSap1yCud, 2)    AS monthSlesSap1yCud,
			ROUND(monthSlesSap3yCud, 2)    AS monthSlesSap3yCud,
			ROUND(monthRhel, 2)            AS monthRhel,
			ROUND(monthRhelSap, 2)         AS monthRhelSap,
			ROUND(monthWindows, 2)         AS monthWindows
		FROM instances
		WHERE name LIKE '$name'
		ORDER BY hour, region;
	~;
	$sth = $dbh->prepare($sql_instance_regions);
	$sth->execute();
	my @instance_regions = ();
	$id = '1';
	while (my $region = $sth->fetchrow_hashref) {
		$region->{'id'} = $id;
		push(@instance_regions, $region);
		$id++;
	}
	$sth->finish;
	my $html_file = '../site/'."$name".'.html';
	print "$html_file\n";
	push(@files, "$name".'.html');
	$template->process('instance.tt2', {
		'instance'  => $instance,
		'instances' => \@instances,
		'regions'   => \@instance_regions
	}, "$html_file") || die "Template process failed: ", $template->error(), "\n";
}


###############################################################################
# DISK
###############################################################################

# Disk in Regions
foreach my $disk (@disks) {
	my $name = $disk->{'name'} || 'missing';
	my $sql_disk_regions = qq ~
		SELECT
			region                         AS name,
			regionLocation                 AS regionLocation,
			zoneCount                      AS zoneCount,
			monthGb
		FROM disks
		WHERE name LIKE '$name'
		ORDER BY monthGb, region;
	~;
	$sth = $dbh->prepare($sql_disk_regions);
	$sth->execute();
	my @disk_regions = ();
	$id = '1';
	while (my $region = $sth->fetchrow_hashref) {
		$region->{'id'} = $id;
		push(@disk_regions, $region);
		$id++;
	}
	$sth->finish;
	my $html_file = '../site/'."$name".'.html';
	print "$html_file\n";
	push(@files, "$name".'.html');
	$template->process('disk.tt2', {
		'disk'    => $disk,
		'regions' => \@disk_regions
	}, "$html_file") || die "Template process failed: ", $template->error(), "\n";
}

###############################################################################
# INSTANCE in REGION
###############################################################################

# Zones
my $sql_zones = "SELECT name, availableCpuPlatforms FROM zones ORDER BY name";
$sth = $dbh->prepare($sql_zones);
$sth->execute();
my @zones = ();
$id = '1';
while (my $zone = $sth->fetchrow_hashref) {
	$zone->{'id'} = $id;
	push(@zones, $zone);
	$id++;
}
$sth->finish;

# Instance in Region
my $sql_instance_in_region = qq ~
SELECT
	UPPER(series) AS series, name, description, family,
	vCpus, LOWER(sharedCpu) AS sharedCpu,
	cpuPlatform, cpuPlatformCount,
	intel, amd, arm, availableCpuPlatform, availableCpuPlatformCount,
	(cpuPlatformCount - availableCpuPlatformCount) AS notAvailableCpuPlatformCount,
	cpuBaseClock, cpuTurboClock, cpuSingleMaxTurboClock,
	coremarkScore, standardDeviation, sampleCount,
	memoryGiB,
	bandwidth, tier1,
	disks, disksSizeGb/1024 AS diskSizeTiB, localSsd,
	acceleratorCount, acceleratorType,
	sap, saps, hana,
	spot,
	region, regionLocation, regionLocationLong, regionLocationCountryCode, regionCfe, regionCo2Kwh, regionLowCo2, regionLat, regionLng, regionPublicIpv4Addr,
	zoneCount, zones,
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
	ROUND(monthWindows, 2)      AS monthWindows,
	ROUND(coremarkScore/hour, 0) AS coremarkHour,
	ROUND(saps/hour, 0)          AS sapsHour
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
	if ($create_region) {
		my $html_file = '../site/'."$region/$name".'.html';
		print "$id : $html_file\n";
		$template->process('instance_in_region.tt2', {
			'instance' => $instance,
			'regions'  => \@regions,
			'zones'    => \@zones,
		}, "$html_file") || die "Template process failed: ", $template->error(), "\n";
	}
	$id++;
}
$sth->finish;


###############################################################################
# COMPARISON
###############################################################################

if ($create_comparison) {
	my $id = '1';
	foreach my $instance_a (@instances) {
		my $name_a = $instance_a->{'name'} || 'missing';
		next if ($limit_comparison && $name_a ne "$limit_comparison");
		$template->process('vs.tt2', {
			'instance_a' => $instance_a,
			'instances'  => \@instances
		}, '../site/comparison/'."$name_a".'/vs.html') || die "Template process failed: ", $template->error(), "\n";
		foreach my $instance_b (@instances) {
			my $name_b = $instance_b->{'name'} || 'missing';
			next if ($name_a eq $name_b);
			# Costs in regions for instance A
			my $sql_regions_for_a = qq ~
				SELECT
					region                         AS region,
					regionLocation                 AS regionLocation,
					regionCfe                      AS regionCfe,
					regionCo2Kwh                   AS regionCo2Kwh,
					regionLowCo2                   AS regionLowCo2,
					zoneCount                      AS zoneCount,
					availableCpuPlatformCount      AS availableCpuPlatformCount,
					ROUND(hour, 4)                 AS hour,
					ROUND(month, 2)                AS month,
					ROUND(month1yCud, 2)           AS month1yCud,
					ROUND(month3yCud, 2)           AS month3yCud
				FROM instances
				WHERE name LIKE '$name_a'
				ORDER BY region;
			~;
			$sth = $dbh->prepare($sql_regions_for_a);
			$sth->execute();
			my @regions_a = ();
			while (my $region = $sth->fetchrow_hashref) {
				push(@regions_a, $region);
			}
			$sth->finish;
			# Costs in regions for instance B
			my $sql_regions_for_b = qq ~
				SELECT
					region                         AS region,
					regionLocation                 AS regionLocation,
					regionCfe                      AS regionCfe,
					regionCo2Kwh                   AS regionCo2Kwh,
					regionLowCo2                   AS regionLowCo2,
					zoneCount                      AS zoneCount,
					availableCpuPlatformCount      AS availableCpuPlatformCount,
					ROUND(hour, 4)                 AS hour,
					ROUND(month, 2)                AS month,
					ROUND(month1yCud, 2)           AS month1yCud,
					ROUND(month3yCud, 2)           AS month3yCud
				FROM instances
				WHERE name LIKE '$name_b'
				ORDER BY region;
			~;
			$sth = $dbh->prepare($sql_regions_for_b);
			$sth->execute();
			my @regions_b = ();
			while (my $region = $sth->fetchrow_hashref) {
				push(@regions_b, $region);
			}
			$sth->finish;
			my $html_file = '../site/comparison/'."$name_a".'/vs/'."$name_b".'.html';
			print "$id : $html_file\n";
			$template->process('comparison.tt2', {
				'instances'  => \@instances,
				'instance_a' => $instance_a,
				'instance_b' => $instance_b,
				'regions'    => \@regions,
				'regions_a'  => \@regions_a,
				'regions_b'  => \@regions_b,
			}, "$html_file") || die "Template process failed: ", $template->error(), "\n";
			$id++;
		}
	}
}


###############################################################################
# IMAGES
###############################################################################

# Operating system details: https://cloud.google.com/compute/docs/images/os-details

$sth = $dbh->prepare("SELECT project AS name, COUNT(name) as imageCount FROM images GROUP BY project ORDER BY project ASC");
$sth->execute();
my @image_projects = ();
while (my $image_project = $sth->fetchrow_hashref) {
	push(@image_projects, $image_project);
}
$sth->finish;

my $sql_image_family = qq ~
SELECT
	project,
	family AS name,
	(SELECT name            FROM images WHERE project LIKE I.project AND family LIKE I.family ORDER BY creation DESC LIMIT 1) AS image,
	(SELECT architecture    FROM images WHERE project LIKE I.project AND family LIKE I.family ORDER BY creation DESC LIMIT 1) AS architecture,
	(SELECT description     FROM images WHERE project LIKE I.project AND family LIKE I.family ORDER BY creation DESC LIMIT 1) AS description,
	(SELECT MAX(diskSizeGb) FROM images WHERE project LIKE I.project AND family LIKE I.family ORDER BY creation DESC LIMIT 1) AS diskSizeGb,
	(SELECT creation        FROM images WHERE project LIKE I.project AND family LIKE I.family ORDER BY creation DESC LIMIT 1) AS creation
FROM images I
GROUP BY project, family
ORDER BY family DESC;
~;
$sth = $dbh->prepare($sql_image_family);
$sth->execute();
my @image_families = ();
while (my $image_family = $sth->fetchrow_hashref) {
	push(@image_families, $image_family);
}
$sth->finish;

push(@files, 'images.html');
$template->process('images.tt2', {
	'image_projects' => \@image_projects,
	'image_famlies'  => \@image_families
}, '../site/images.html') || die "Template process failed: ", $template->error(), "\n";


###############################################################################
# MISC
###############################################################################

# Index
$template->process('index.tt2', {
	'instances'            => \@instances,
	'disks'                => \@disks,
	'regions'              => \@regions,
	'instances_in_regions' => \@instances_in_regions
}, '../site/index.html') || die "Template process failed: ", $template->error(), "\n";

# Grid
push(@files, 'grid.html');
my $json = encode_json \@instances_in_regions;
$json    = decode('UTF-8', $json); # force UTF-8
$template->process('main.js',                 {},                  '../site/main.js')                 || die "Template process failed: ", $template->error(), "\n";
$template->process('grid.tt2',                {},                  '../site/grid.html')               || die "Template process failed: ", $template->error(), "\n";
$template->process('instance_in_region.json', { 'json' => $json }, '../site/instance_in_region.json') || die "Template process failed: ", $template->error(), "\n";

# Download
push(@files, 'download.html');
$template->process('download.tt2', {
	'csvFileSize'      => $filesize_csv_export,
	'sqlFileSize'      => $filesize_sql_export,
}, '../site/download.html') || die "Template process failed: ", $template->error(), "\n";

# Imprint
$template->process('imprint.tt2', {}, '../site/imprint.html') || die "Template process failed: ", $template->error(), "\n";

# 404
$template->process('404.tt2', {}, '../site/404.html') || die "Template process failed: ", $template->error(), "\n";

# Sitemap
$template->process('sitemap.tt2', { 'files' => \@files }, '../site/sitemap.txt') || die "Template process failed: ", $template->error(), "\n";

# Robots.txt
$template->process('robots.txt', {}, '../site/robots.txt')     || die "Template process failed: ", $template->error(), "\n";

# SQL
copy("$sql_export", '../site/machine-types-regions.sql.gz');
# CSV
copy("$csv_export", '../site/machine-types-regions.csv');

# Images
mkdir('../site/img/');
copy( './src/img/combine-filter.png', '../site/img/combine-filter.png');
copy( './src/img/filter.png',         '../site/img/filter.png');
copy( './src/img/show-more.png',      '../site/img/show-more.png');
copy( './src/img/sort.png',           '../site/img/sort.png');
copy( './src/img/spreadsheet.png',    '../site/img/spreadsheet.png');
copy( './src/img/dbbrowser.png',      '../site/img/dbbrowser.png');

# Favicon
copy( './src/img/favicon/favicon.ico',                '../site/favicon.ico');
copy( './src/img/favicon/favicon-16x16.png',          '../site/favicon-16x16.png');
copy( './src/img/favicon/favicon-32x32.png',          '../site/favicon-32x32.png');
copy( './src/img/favicon/apple-touch-icon.png',       '../site/apple-touch-icon.png');
copy( './src/img/favicon/android-chrome-192x192.png', '../site/android-chrome-192x192.png');
copy( './src/img/favicon/android-chrome-512x512.png', '../site/android-chrome-512x512.png');
copy( './src/img/favicon/site.webmanifest',           '../site/site.webmanifest');

print "DONE\n";