/* C3 Compute-optimized */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* TODO: Check again if GA */
UPDATE instances SET
series      = 'c3',
family      = 'General-purpose',
cpuPlatform = 'Sapphire Rapids',
localSsd    = '1',
bandwidth   = '32',
spot        = '1'
WHERE name LIKE 'c3-%';

UPDATE instances SET bandwidth = '32'  WHERE name LIKE 'c3-highcpu-4';
UPDATE instances SET bandwidth = '32'  WHERE name LIKE 'c3-highcpu-8';
UPDATE instances SET bandwidth = '32'  WHERE name LIKE 'c3-highcpu-22';
UPDATE instances SET bandwidth = '32'  WHERE name LIKE 'c3-highcpu-44';
UPDATE instances SET bandwidth = '62'  WHERE name LIKE 'c3-highcpu-88';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'c3-highcpu-176';

UPDATE instances SET tier1 = '50'  WHERE name LIKE 'c3-highcpu-44';
UPDATE instances SET tier1 = '100' WHERE name LIKE 'c3-highcpu-88';
UPDATE instances SET tier1 = '200' WHERE name LIKE 'c3-highcpu-176';