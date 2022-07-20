#!/usr/bin/env bash

#
# Add number of public IP addresses for each GCP region
#

source "00_config.sh" || exit 9

echo "Get public IP ranges"
curl -o "publicipranges.json" "https://www.gstatic.com/ipranges/cloud.json" || exit 9

echo "Calculate public IP addresses"
perl "08_publicipranges.pl" > "publicipaddresses.sql" || exit 9

echo "Add number of public IP addresses for each GCP region"
sqlite3 "$DB" < "publicipaddresses.sql" || exit 9