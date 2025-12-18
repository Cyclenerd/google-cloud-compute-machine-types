#!/usr/bin/env bash
set -e

#
# Add more machine type informations
#

source "00_config.sh"

echo "Frequency (GHz)"
sqlite3 "$DB" < "../instances/series/cpu/frequency.sql"

echo "EEMBC CoreMark Benchmark"
sqlite3 "$DB" < "../instances/series/cpu/coremark.sql"

echo "GPU Type Names"
sqlite3 "$DB" < "../instances/series/gpu/gpu_names.sql"

echo "SAP certified machine types"
sqlite3 "$DB" < "../instances/series/sap/sap.sql"

echo "SAP HANA certified machine types"
sqlite3 "$DB" < "../instances/series/sap/hana.sql"