#!/usr/bin/env bash
set -e

#
# Add additional machine type and region informations
#

source "00_config.sh"

for MY_SERIES in ../instances/series/*.sql; do
	echo "$MY_SERIES"
	sqlite3 "$DB" < "$MY_SERIES"
done

echo "Add carbon data across GCP regions"
sqlite3 "$DB" < ../regions/carbon.sql

echo "Add long location name, latitude and longitude of GCP regions"
sqlite3 "$DB" < ../regions/regions.sql

echo "Add extra data for GCP regions"
sqlite3 "$DB" < ../regions/extra.sql

echo "Add country names of GCP regions"
sqlite3 "$DB" < ../regions/country.sql