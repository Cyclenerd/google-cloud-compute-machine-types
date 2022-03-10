/* A2 Accelerator-optimized high-gpu */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/accelerator-optimized-machines#a2_vms */
UPDATE instances SET
series      = 'a2',
family      = 'Accelerator-optimized',
cpuPlatform = 'Cascade Lake',
localSsd    = '1',
spot        = '1'
WHERE name LIKE 'a2-%';
UPDATE instances SET bandwidth = '24'  WHERE name LIKE 'a2-%-1g';
UPDATE instances SET bandwidth = '32'  WHERE name LIKE 'a2-%-2g';
UPDATE instances SET bandwidth = '50'  WHERE name LIKE 'a2-%-4g';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'a2-%-8g';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'a2-%-16g';