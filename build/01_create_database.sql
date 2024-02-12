/*
 * Create SQLite3 database for GCE machine type informations
 */

DROP TABLE IF EXISTS "machinetypes";
CREATE TABLE "machinetypes" (
	"name"                         TEXT NOT NULL DEFAULT '',
	'description'                  TEXT NOT NULL DEFAULT '',
	'location'                     TEXT NOT NULL DEFAULT '',
	'region'                       TEXT NOT NULL DEFAULT '',
	'zone'                         TEXT NOT NULL DEFAULT '',
	'guestCpus'                    INT  NOT NULL DEFAULT '0',
	'isSharedCpu'                  TEXT NOT NULL DEFAULT 'false',
	'memoryGiB'                    REAL NOT NULL DEFAULT '0.0',
	'guestAcceleratorCount'        INT  NOT NULL DEFAULT '0',
	'guestAcceleratorType'         TEXT NOT NULL DEFAULT '',
	'maximumPersistentDisks'       INT  NOT NULL DEFAULT '0',
	'maximumPersistentDisksSizeGb' INT  NOT NULL DEFAULT '0',
	PRIMARY KEY("name", "zone")
);

DROP TABLE IF EXISTS "zones";
CREATE TABLE "zones" (
	"name"                  TEXT NOT NULL DEFAULT '',
	'availableCpuPlatforms' TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("name")
);

DROP TABLE IF EXISTS "instances";
CREATE TABLE "instances" (
	"name"                      TEXT NOT NULL DEFAULT '',
	"series"                    TEXT DEFAULT 'TODO',
	"family"                    TEXT DEFAULT 'TODO',
	"description"               TEXT DEFAULT '',
	"location"                  TEXT NOT NULL DEFAULT '',
	"region"                    TEXT NOT NULL DEFAULT '',
	"regionLocation"            TEXT NOT NULL DEFAULT '',
	"regionLocationLong"        TEXT NOT NULL DEFAULT '',
	"regionLocationCountryCode" TEXT NOT NULL DEFAULT '',
	"regionCfe"                 REAL DEFAULT '',
	"regionCo2Kwh"              REAL DEFAULT '',
	"regionLowCo2"              REAL DEFAULT '0.0',
	"regionLat"                 REAL DEFAULT '0.0',
	"regionLng"                 REAL DEFAULT '0.0',
	"regionPublicIpv4Addr"      REAL DEFAULT '0.0',
	"zoneCount"                 REAL DEFAULT '0.0',
	"zones"                     TEXT DEFAULT '',
	"vCpus"                     REAL DEFAULT '0.0',
	"sharedCpu"                 TEXT DEFAULT 'false',
	"intel"                     REAL DEFAULT '0.0',
	"amd"                       REAL DEFAULT '0.0',
	"arm"                       REAL DEFAULT '0.0',
	"cpuPlatformCount"          REAL DEFAULT '0.0',
	"cpuPlatform"               TEXT DEFAULT '',
	"cpuBaseClock"              REAL DEFAULT '0.0',
	"cpuTurboClock"             REAL DEFAULT '0.0',
	"cpuSingleMaxTurboClock"    REAL DEFAULT '0.0',
	"availableCpuPlatformCount" REAL DEFAULT '0.0',
	"availableCpuPlatform"      TEXT DEFAULT '',
	"coremarkScore"             REAL DEFAULT '',
	"standardDeviation"         REAL DEFAULT '',
	"sampleCount"               REAL DEFAULT '',
	"memoryGiB"                 REAL DEFAULT '0.0',
	"acceleratorCount"          REAL DEFAULT '0.0',
	"acceleratorType"           TEXT DEFAULT '',
	"disks"                     REAL DEFAULT '0.0',
	"disksSizeGb"               REAL DEFAULT '0.0',
	"localSsd"                  REAL DEFAULT '0.0',
	"bandwidth"                 REAL DEFAULT '0.0',
	"tier1"                     REAL DEFAULT '0.0',
	"sap"                       REAL DEFAULT '0.0',
	"saps"                      REAL DEFAULT '',
	"hana"                      REAL DEFAULT '0.0',
	"sud"                       REAL DEFAULT '0.0',
	"spot"                      REAL DEFAULT '0.0',
	"hour"                      REAL DEFAULT '0.0',
	"hourSpot"                  REAL DEFAULT '0.0',
	"hourSpotDiscount"          REAL DEFAULT '0.0',
	"hourSpotDiscountPercent"   REAL DEFAULT '0.0',
	"month"                     REAL DEFAULT '0.0',
	"month1yCud"                REAL DEFAULT '0.0',
	"month1yCudDiscount"        REAL DEFAULT '0.0',
	"month1yCudDiscountPercent" REAL DEFAULT '0.0',
	"month3yCud"                REAL DEFAULT '0.0',
	"month3yCudDiscount"        REAL DEFAULT '0.0',
	"month3yCudDiscountPercent" REAL DEFAULT '0.0',
	"monthSpot"                 REAL DEFAULT '0.0',
	"monthSpotDiscount"         REAL DEFAULT '0.0',
	"monthSpotDiscountPercent"  REAL DEFAULT '0.0',
	"monthSles"                 REAL DEFAULT '0.0',
	"monthSlesSap"              REAL DEFAULT '0.0',
	"monthSlesSap1yCud"         REAL DEFAULT '0.0',
	"monthSlesSap3yCud"         REAL DEFAULT '0.0',
	"monthRhel"                 REAL DEFAULT '0.0',
	"monthRhel1yCud"            REAL DEFAULT '0.0',
	"monthRhel3yCud"            REAL DEFAULT '0.0',
	"monthRhelSap"              REAL DEFAULT '0.0',
	"monthRhelSap1yCud"         REAL DEFAULT '0.0',
	"monthRhelSap3yCud"         REAL DEFAULT '0.0',
	"monthWindows"              REAL DEFAULT '0.0',
	PRIMARY KEY("name", "region")
);

DROP TABLE IF EXISTS "disktypes";
CREATE TABLE "disktypes" (
	"name"        TEXT NOT NULL DEFAULT '',
	'description' TEXT NOT NULL DEFAULT '',
	'location'    TEXT NOT NULL DEFAULT '',
	'region'      TEXT NOT NULL DEFAULT '',
	'zone'        TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("name", "zone")
);

DROP TABLE IF EXISTS "disks";
CREATE TABLE "disks" (
	"name"           TEXT NOT NULL DEFAULT '',
	"description"    TEXT DEFAULT '',
	"location"       TEXT NOT NULL DEFAULT '',
	"region"         TEXT NOT NULL DEFAULT '',
	"regionLocation" TEXT NOT NULL DEFAULT '',
	"zoneCount"      REAL DEFAULT '0.0',
	"zones"          TEXT DEFAULT '',
	"monthGb"        REAL DEFAULT '0.0',
	PRIMARY KEY("name", "region")
);

DROP TABLE IF EXISTS "images";
CREATE TABLE "images" (
	"name"         TEXT NOT NULL DEFAULT '',
	"description"  TEXT DEFAULT '',
	"diskSizeGb"   REAL DEFAULT '0.0',
	"project"      TEXT NOT NULL DEFAULT '',
	"family"       TEXT NOT NULL DEFAULT '',
	"architecture" TEXT NOT NULL DEFAULT '',
	"creation"     REAL DEFAULT '0.0',
	PRIMARY KEY("name", "project", "family")
);

/* Index */
CREATE INDEX IF NOT EXISTS "instances-name-index" ON instances(name COLLATE NOCASE);
CREATE INDEX IF NOT EXISTS "instances-region-index" ON instances(region COLLATE NOCASE);
CREATE INDEX IF NOT EXISTS "instances-region-name-index" ON instances(region, name COLLATE NOCASE);
CREATE INDEX IF NOT EXISTS "instances-region-hana-index" ON instances(region, hana);
CREATE INDEX IF NOT EXISTS "instances-region-sap-index" ON instances(region, sap);
CREATE INDEX IF NOT EXISTS "instances-region-series-index" ON instances(region, series COLLATE NOCASE);

CREATE INDEX IF NOT EXISTS "disks-name-index" ON disks(name COLLATE NOCASE);
CREATE INDEX IF NOT EXISTS "disks-region-index" ON disks(region COLLATE NOCASE);