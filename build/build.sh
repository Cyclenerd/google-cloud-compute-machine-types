#!/usr/bin/env bash

echo "1. Create"
bash "01_create_database.sh" || exit 9 9

echo "2. Get"
bash "02_get.sh" || exit 9

echo "3. Copy"
perl "03_copy.pl" || exit 9

echo "4. Clean up"
bash "04_clean_up.sh" || exit 9

echo "5. Copy instances"
perl "05_copy_instances.pl" || exit 9

echo "6. Add costs"
perl "06_add_costs.pl" || exit 9

echo "7. Add informations"
bash "07_add.sh" || exit 9

echo "8. Add available CPU platforms"
perl 08_cpu.pl || exit 9

echo "9. Add more"
bash "09_more.sh" || exit 9

echo "10. Export"
bash "10_export.sh" || exit 9

echo "11. Test"
bash "11_test.sh" || exit 9