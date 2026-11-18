#!/usr/bin/env bash
set -euo pipefail

# Offline enrichment test: no gcloud calls or pricing downloads.
cd "$(dirname "$0")"
MY_DB=$(mktemp)
trap 'rm -f "$MY_DB"' EXIT
sqlite3 "$MY_DB" < 01_create_database.sql
sqlite3 "$MY_DB" <<'SQL'
INSERT INTO instances (name, region) VALUES
('z4m-highmem-16', 'us-central1'),
('z4m-highmem-32', 'us-central1'),
('z4m-highmem-48', 'us-central1'),
('z4m-highmem-192', 'us-central1'),
('z4m-highmem-192-metal', 'us-central1'),
('n2-standard-8', 'us-central1');
SQL

MY_EXPECTED='z4m-highmem-16|z4m|Storage-optimized|Emerald Rapids|14000.0|32.0|0.0|1.0
z4m-highmem-192|z4m|Storage-optimized|Emerald Rapids|168000.0|400.0|0.0|1.0
z4m-highmem-192-metal|z4m|Storage-optimized|Emerald Rapids|168000.0|400.0|0.0|0.0
z4m-highmem-32|z4m|Storage-optimized|Emerald Rapids|28000.0|67.0|0.0|1.0
z4m-highmem-48|z4m|Storage-optimized|Emerald Rapids|42000.0|100.0|0.0|1.0'

# Apply twice to check idempotency.
for MY_PASS in 1 2; do
	sqlite3 "$MY_DB" < ../instances/series/z4m.sql
	MY_ACTUAL=$(sqlite3 "$MY_DB" "SELECT name, series, family, cpuPlatform, localSsd, bandwidth, sud, spot FROM instances WHERE name LIKE 'z4m-%' ORDER BY name;")
	if [ "$MY_ACTUAL" != "$MY_EXPECTED" ]; then
		echo "ERROR: unexpected Z4M metadata (pass $MY_PASS)"
		printf '%s\n' "$MY_ACTUAL"
		exit 1
	fi
	MY_CONTROL=$(sqlite3 "$MY_DB" "SELECT series, family, cpuPlatform, localSsd, bandwidth, sud, spot FROM instances WHERE name = 'n2-standard-8';")
	test "$MY_CONTROL" = 'TODO|TODO||0.0|0.0|0.0|0.0'
done

echo "DONE: Z4M enrichment and non-Z4M control"
