#!/usr/bin/env bash
set -e

#
# Export all Google Compute Engine machine types and zones via the
# Google Compute Engine API and create CSV file
#

source "00_config.sh"

echo "Download pricing..."
curl -OL "https://github.com/Cyclenerd/google-cloud-pricing-cost-calculator/raw/master/pricing.yml"
echo

# Create CSV file with machine types
echo "Executing: 'gcloud compute machine-types list', please wait..."
printf "%s;" \
	"name" \
	"description" \
	"zone" \
	"guestCpus" \
	"isSharedCpu" \
	"memoryGB" \
	"guestAcceleratorCount" \
	"guestAcceleratorType" \
	"maximumPersistentDisks" \
	"maximumPersistentDisksSizeGb" \
	"deprecated" > "$CSV_GCLOUD_MACHINE_TYPES"
echo "" >> "$CSV_GCLOUD_MACHINE_TYPES"
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
		deprecated.state)" >> "$CSV_GCLOUD_MACHINE_TYPES"

# Create CSV file with zones and available CPU platforms
echo "Executing: 'gcloud compute zones list', please wait..."
printf "%s;" \
	"name" \
	"availableCpuPlatforms" > "$CSV_GCLOUD_ZONES"
echo "" >> "$CSV_GCLOUD_ZONES"
gcloud compute zones list \
	--quiet \
	--format="csv[no-heading,separator=';'](name, availableCpuPlatforms.list())" >> "$CSV_GCLOUD_ZONES"
# Fix Google Axion CPU platform name:
# Parse the CSV file line by line. If 'Google Axion' is in line and 'Google Axion_' remove 'Google Axion_'.
perl -i -pe "s/Google Axion_,//g if /Google Axion/" "$CSV_GCLOUD_ZONES"
perl -i -pe "s/Google Axion_//g if /Google Axion/" "$CSV_GCLOUD_ZONES"

# Create CSV file with disk types
echo "Executing: 'gcloud compute disk-types list', please wait..."
printf "%s;" \
	"name" \
	"zone" \
	"description" > "$CSV_GCLOUD_DISK_TYPES"
echo "" >> "$CSV_GCLOUD_DISK_TYPES"
gcloud compute disk-types list \
	--quiet \
	--filter="ZONE:-" \
	--format="csv[no-heading,separator=';']( \
		name, \
		zone, \
		description)" >> "$CSV_GCLOUD_DISK_TYPES"

# Create CSV files with images
echo "Executing: 'gcloud compute images list', please wait..."

# Standard images
echo "name;description;diskSizeGb;project;family;architecture;creation;deprecated;status" > "$CSV_GCLOUD_IMAGES"
gcloud compute images list \
	--quiet \
	--format="csv[no-heading,separator=';'](NAME,description,diskSizeGb,PROJECT,FAMILY,architecture,creationTimestamp,DEPRECATED,STATUS)" >> "$CSV_GCLOUD_IMAGES"

# Community images
# https://cloud.google.com/compute/docs/images#almalinux
gcloud compute images list \
	--project almalinux-cloud \
	--no-standard-images \
	--quiet \
	--format="csv[no-heading,separator=';'](NAME,description,diskSizeGb,PROJECT,FAMILY,architecture,creationTimestamp,DEPRECATED,STATUS)" >> "$CSV_GCLOUD_IMAGES"
# https://cloud.google.com/compute/docs/images#freebsd
gcloud compute images list \
	--project freebsd-org-cloud-dev \
	--no-standard-images \
	--quiet \
	--format="csv[no-heading,separator=';'](NAME,description,diskSizeGb,PROJECT,FAMILY,architecture,creationTimestamp,DEPRECATED,STATUS)" >> "$CSV_GCLOUD_IMAGES"

# Deep Learning on Linux images
gcloud compute images list \
	--project ml-images \
	--filter="creationTimestamp > -P1Y" \
	--no-standard-images \
	--quiet \
	--format="csv[no-heading,separator=';'](NAME,description,diskSizeGb,PROJECT,FAMILY,architecture,creationTimestamp,DEPRECATED,STATUS)" >> "$CSV_GCLOUD_IMAGES"
# https://cloud.google.com/deep-learning-vm/docs/images#listing-versions
gcloud compute images list \
	--project deeplearning-platform-release \
	--filter="creationTimestamp > -P1Y" \
	--no-standard-images \
	--quiet \
	--format="csv[no-heading,separator=';'](NAME,description,diskSizeGb,PROJECT,FAMILY,architecture,creationTimestamp,DEPRECATED,STATUS)" >> "$CSV_GCLOUD_IMAGES"

# High Performance Computing (HPC)
gcloud compute images list \
	--project cloud-hpc-image-public \
	--filter="creationTimestamp > -P1Y" \
	--no-standard-images \
	--quiet \
	--format="csv[no-heading,separator=';'](NAME,description,diskSizeGb,PROJECT,FAMILY,architecture,creationTimestamp,DEPRECATED,STATUS)" >> "$CSV_GCLOUD_IMAGES"
echo "DONE"