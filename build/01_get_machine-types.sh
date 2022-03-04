#!/usr/bin/env bash

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
# Export all Google Compute Engine machine types via the
# Google Compute Engine API and create a CSV file
#

FILE="machinetypes.csv"

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
	"deprecated" > "$FILE" || exit
echo "" >> "$FILE" || exit
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
		deprecated.state)" >> "$FILE" || exit