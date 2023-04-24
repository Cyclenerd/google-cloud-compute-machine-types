/* G2 Accelerator-optimized machines */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/accelerator-optimized-machines#g2-vms */
UPDATE instances SET
series      = 'g2',
family      = 'Accelerator-optimized',
cpuPlatform = 'Cascade Lake',
localSsd    = '1',
spot        = '1'
WHERE name LIKE 'g2-%';
UPDATE instances SET bandwidth = '10'  WHERE name LIKE 'g2-standard-4';
UPDATE instances SET bandwidth = '16'  WHERE name LIKE 'g2-standard-8';
UPDATE instances SET bandwidth = '16'  WHERE name LIKE 'g2-standard-12';
UPDATE instances SET bandwidth = '32'  WHERE name LIKE 'g2-standard-16';
UPDATE instances SET bandwidth = '32'  WHERE name LIKE 'g2-standard-24';
UPDATE instances SET bandwidth = '32'  WHERE name LIKE 'g2-standard-32';
UPDATE instances SET bandwidth = '50'  WHERE name LIKE 'g2-standard-48';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'g2-standard-96';