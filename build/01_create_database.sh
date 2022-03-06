#!/usr/bin/env bash

#
# Create SQLite3 database for GCE machine type informations
#

source "00_config.sh" || exit

sqlite3 "$DB" < "01_create_database.sql" || exit