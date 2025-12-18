#!/usr/bin/env bash
set -e

echo "1. Create"
bash "01_create_database.sh"

echo "2. Get"
bash "02_get.sh"

echo "3. Copy"
perl "03_copy.pl"

echo "4. Clean up"
bash "04_clean_up.sh"

echo "5. Copy instances and disks"
perl "05_copy_instances.pl"
perl "05_copy_disks.pl"

echo "6. Add costs"
perl "06_add_costs.pl"

echo "7. Add informations"
bash "07_add.sh"

echo "8.1. Add available CPU platforms"
perl "08_cpu.pl"

echo "8.2. Add number of public IP addresses"
bash "08_publicipranges.sh"

echo "9. Add more"
bash "09_more.sh"

echo "10. Export"
bash "10_export.sh"

echo "11. Test"
bash "11_test.sh"