#!/usr/bin/env bash

#
# Export all Google Compute Engine machine types and zones via the
# Google Compute Engine API and create CSV file
#

source "00_config.sh" || exit

# Create CSV file with machine types
echo "Executing: 'gcloud compute machine-types list', please wait..."
printf "%s;" \
	"name" \
	"description" \
	"zone" \
	"guestCpus" \
	"isSharedCpu" \
	"memoryGiB" \
	"guestAcceleratorCount" \
	"guestAcceleratorType" \
	"maximumPersistentDisks" \
	"maximumPersistentDisksSizeGb" \
	"deprecated" > "$CSV_GCLOUD_MACHINE_TYPES" || exit
echo "" >> "$CSV_GCLOUD_MACHINE_TYPES" || exit
gcloud compute machine-types list \
	--quiet \
	--filter="ZONE:-" \
	--format="csv[no-heading,separator=';']( \
		name, \
		description, \
		zone, \
		guestCpus, \
		isSharedCpu, \
		MEMORY_GB, \
		accelerators.guestAcceleratorCount, \
		accelerators.guestAcceleratorType, \
		maximumPersistentDisks, \
		maximumPersistentDisksSizeGb, \
		deprecated.state)" >> "$CSV_GCLOUD_MACHINE_TYPES" || exit

# Create CSV file with zones and available CPU platforms
echo "Executing: 'gcloud compute zones list', please wait..."
printf "%s;" \
	"name" \
	"availableCpuPlatforms" > "$CSV_GCLOUD_ZONES" || exit
echo "" >> "$CSV_GCLOUD_ZONES" || exit
gcloud compute zones list \
	--quiet \
	--format="csv[no-heading,separator=';'](name, availableCpuPlatforms.list())" >> "$CSV_GCLOUD_ZONES" || exit

echo "DONE"