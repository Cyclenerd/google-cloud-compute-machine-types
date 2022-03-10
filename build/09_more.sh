#!/usr/bin/env bash

#
# Add more machine type informations
#

source "00_config.sh" || exit

echo "Frequency (GHz)"
sqlite3 "$DB" < "../instances/series/cpu/frequency.sql" || exit

echo "EEMBC CoreMark Benchmark"
sqlite3 "$DB" < "../instances/series/cpu/coremark.sql" || exit

echo "SAP certified machine types"
sqlite3 "$DB" < "../instances/series/sap/sap.sql" || exit

echo "SAP HANA certified machine types"
sqlite3 "$DB" < "../instances/series/sap/hana.sql" || exit