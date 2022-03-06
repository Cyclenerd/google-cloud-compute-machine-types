#!/usr/bin/env bash

#
# Export all Google Compute Engine machine types via the
# Google Compute Engine API and create a CSV file
#

source "00_config.sh" || exit

# Create CSV file
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
	"deprecated" > "$CSV_GCLOUD" || exit
echo "" >> "$CSV_GCLOUD" || exit
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
		deprecated.state)" >> "$CSV_GCLOUD" || exit