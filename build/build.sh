#!/usr/bin/env bash

DB='gce.db'
EXPORT='machine-types-regions.csv'

echo "1. Create"
sqlite3 "$DB" < "00_create_database.sql" || exit

echo "2. Get"
bash "01_get_machine-types.sh" || exit

echo "3. Copy"
perl "03_copy_machine-types.pl" || exit

echo "4. Clean up"
sqlite3 "$DB" < ../instances/clean_up.sql || exit

echo "5. Copy instances"
perl "05_copy_instances.pl" || exit

echo "6. Add costs"
perl "06_add_costs.pl" || exit

echo "7. Add additional machine type informations"
for MY_SERIES in ../instances/series/*.sql; do
	echo "$MY_SERIES"
	sqlite3 "$DB" < "$MY_SERIES" || exit
done

echo "» Export"
sqlite3 -header -csv "$DB" "SELECT * FROM instances ORDER BY region, name;" > "$EXPORT" || exit

# Check TODOs
if grep 'TODO' < "$EXPORT"; then
	echo "🔥 ERROR: There are still TODOs"
	exit 9
fi

# Check costs
# n2-standard-8 in europe-west4 with SUD : 249
if ! cat "$EXPORT" | grep 'n2-standard-8,' | grep 'europe-west4,' | head -n 1 | grep ',249' > /dev/null; then
	echo "🔥 ERROR: n2-standard-8 in europe-west4 with cost 249 not found"
	exit 9
fi

echo "✅ DONE"