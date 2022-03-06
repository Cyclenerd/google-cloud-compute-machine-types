#!/usr/bin/env bash

#
# Clean up (Remove disconnected data centers...)
#

source "00_config.sh" || exit

sqlite3 "$DB" < "../instances/clean_up.sql" || exit