#!/usr/bin/env bash

#
# Export CSV and SQL file
#

source "00_config.sh" || exit

echo "» SQL Export"
echo 'DROP TABLE IF EXISTS "instances";' > "$SQL_EXPORT" || exit
sqlite3 "$DB" '.dump instances' >> "$SQL_EXPORT" || exit
gzip -fk "$SQL_EXPORT" || exit

echo "» CSV Export"
sqlite3     \
	-header \
	-csv "$DB" "SELECT * FROM instances ORDER BY region, name;" > "$CSV_EXPORT" || exit
