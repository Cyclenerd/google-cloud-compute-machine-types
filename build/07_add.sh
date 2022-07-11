#!/usr/bin/env bash

#
# Add additional machine type and region informations
#

source "00_config.sh" || exit 9

for MY_SERIES in ../instances/series/*.sql; do
	echo "$MY_SERIES"
	sqlite3 "$DB" < "$MY_SERIES" || exit 9
done

echo "Add extra data for GCP regions"
sqlite3 "$DB" < ../regions/extra.sql  || exit 9

echo "Carbon data across GCP regions"
sqlite3 "$DB" < ../regions/carbon.sql || exit 9