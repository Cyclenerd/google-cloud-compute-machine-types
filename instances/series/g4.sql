/* G4 Accelerator-optimized machines */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/accelerator-optimized-machines#g4-vms */
UPDATE instances SET
series      = 'g4',
family      = 'Accelerator-optimized',
cpuPlatform = 'Turin',
localSsd    = '1',
spot        = '1'
WHERE name LIKE 'g4-%';
UPDATE instances SET bandwidth = '20'  WHERE name LIKE 'g4-standard-6';
UPDATE instances SET bandwidth = '20'  WHERE name LIKE 'g4-standard-12';
UPDATE instances SET bandwidth = '20'  WHERE name LIKE 'g4-standard-24';
UPDATE instances SET bandwidth = '50'  WHERE name LIKE 'g4-standard-48';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'g4-standard-96';
UPDATE instances SET bandwidth = '200' WHERE name LIKE 'g4-standard-192';
UPDATE instances SET bandwidth = '400' WHERE name LIKE 'g4-standard-384';
