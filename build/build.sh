#!/usr/bin/env bash

echo "1. Create"
bash "01_create_database.sh" || exit

echo "2. Get"
bash "02_get_machine-types.sh" || exit

echo "3. Copy"
perl "03_copy_machine-types.pl" || exit

echo "4. Clean up"
bash "04_clean_up.sh" || exit

echo "5. Copy instances"
perl "05_copy_instances.pl" || exit

echo "6. Add costs"
perl "06_add_costs.pl" || exit

echo "7. Add informations"
bash "07_add_information.sh" || exit

echo "8. Export"
bash "08_export.sh" || exit

echo "9. Test"
bash "09_test.sh" || exit