#!/usr/bin/env bash

source "00_config.sh" || exit 9

CSV_EXPORT="costs-$(date +'%Y-%m-%d').csv"

sqlite3     \
	-header \
	-csv "$DB" < "history.sql" > "$CSV_EXPORT" || exit 9