#!/usr/bin/env bash
set -e

#
# Create SQLite3 database for GCE machine type informations
#

source "00_config.sh"

sqlite3 "$DB" < "01_create_database.sql"