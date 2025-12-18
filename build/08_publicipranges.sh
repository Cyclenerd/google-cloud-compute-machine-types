#!/usr/bin/env bash
set -e

#
# Add number of public IP addresses for each GCP region
#

source "00_config.sh"

echo "Get public IP ranges"
curl -o "publicipranges.json" "https://www.gstatic.com/ipranges/cloud.json"

echo "Calculate public IP addresses"
perl "08_publicipranges.pl" > "publicipaddresses.sql"

echo "Add number of public IP addresses for each GCP region"
sqlite3 "$DB" < "publicipaddresses.sql"