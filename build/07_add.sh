#!/usr/bin/env bash

#
# Add additional machine type and region informations
#

source "00_config.sh" || exit 9

for MY_SERIES in ../instances/series/*.sql; do
	echo "$MY_SERIES"
	sqlite3 "$DB" < "$MY_SERIES" || exit 9
done

echo "Add carbon data across GCP regions"
sqlite3 "$DB" < ../regions/carbon.sql || exit 9

echo "Add long location name, latitude and longitude of GCP regions"
sqlite3 "$DB" < ../regions/regions.sql || exit 9

echo "Add country names of GCP regions"
sqlite3 "$DB" < ../regions/country.sql || exit 9

echo "Add extra data for GCP regions"
sqlite3 "$DB" < ../regions/extra.sql  || exit 9