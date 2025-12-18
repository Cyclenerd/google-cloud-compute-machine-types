#!/usr/bin/env bash
set -e

#
# Clean up (Remove disconnected data centers...)
#

source "00_config.sh"

sqlite3 "$DB" < "../instances/clean_up.sql"