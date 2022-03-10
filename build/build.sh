#!/usr/bin/env bash

echo "1. Create"
bash "01_create_database.sh" || exit

echo "2. Get"
bash "02_get.sh" || exit

echo "3. Copy"
perl "03_copy.pl" || exit

echo "4. Clean up"
bash "04_clean_up.sh" || exit

echo "5. Copy instances"
perl "05_copy_instances.pl" || exit

echo "6. Add costs"
perl "06_add_costs.pl" || exit

echo "7. Add informations"
bash "07_add.sh" || exit

echo "8. Add available CPU platforms"
perl 08_cpu.pl || exit

echo "9. Add more"
bash "09_more.sh" || exit

echo "10. Export"
bash "10_export.sh" || exit

echo "11. Test"
bash "11_test.sh" || exit