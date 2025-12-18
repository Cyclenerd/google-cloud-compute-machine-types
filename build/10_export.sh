#!/usr/bin/env bash
set -e

#
# Export CSV and SQL file
#

source "00_config.sh"

echo "» SQL Export"
{
	echo 'DROP TABLE IF EXISTS "instances";'
	sqlite3 "$DB" '.dump instances'
	echo 'DROP TABLE IF EXISTS "disks";'
	sqlite3 "$DB" '.dump disks'
	echo 'DROP TABLE IF EXISTS "images";'
	sqlite3 "$DB" '.dump images'
} > "$SQL_EXPORT"
gzip -fk "$SQL_EXPORT"

echo "» CSV Export"
sqlite3     \
	-header \
	-csv "$DB" "SELECT * FROM instances ORDER BY region, name;" > "$CSV_EXPORT"
