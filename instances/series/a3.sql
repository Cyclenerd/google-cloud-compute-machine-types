/* A3 Accelerator-optimized machine family */
/* https://cloud.google.com/compute/docs/accelerator-optimized-machines#a3-vms */
UPDATE instances SET
series      = 'a3',
family      = 'Accelerator-optimized',
cpuPlatform = 'Sapphire Rapids',
localSsd    = '1',
bandwidth   = '200',
spot        = '1'
WHERE name LIKE 'a3-%';

UPDATE instances SET localSsd = '6000' WHERE name LIKE 'a3-%-8g';

UPDATE instances SET bandwidth = '800'  WHERE name LIKE 'a3-highgpu-8g';
UPDATE instances SET bandwidth = '1600' WHERE name LIKE 'a3-megagpu-8g';
