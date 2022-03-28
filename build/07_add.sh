#!/usr/bin/env bash

#
# Add additional machine type informations
#

source "00_config.sh" || exit 9

for MY_SERIES in ../instances/series/*.sql; do
	echo "$MY_SERIES"
	sqlite3 "$DB" < "$MY_SERIES" || exit 9
done