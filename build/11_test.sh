#!/usr/bin/env bash
set -e

#
# Test
#

source "00_config.sh"

# Check TODOs
if grep 'TODO' < "$CSV_EXPORT"; then
	echo "ERROR: There are still TODOs"
	exit 9
fi

# Check costs
# n2-standard-8 in europe-west4 with SUD : 249
if ! cat "$CSV_EXPORT" | grep 'n2-standard-8,' | grep 'europe-west4,' | head -n 1 | grep ',249' > /dev/null; then
	echo "ERROR: n2-standard-8 in europe-west4 with cost 249 not found"
	exit 9
fi

echo "DONE"