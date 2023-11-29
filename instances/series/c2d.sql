/* C2D Compute-optimized */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/compute-optimized-machines#c2d-standard */
UPDATE instances SET
series      = 'c2d',
family      = 'Compute-optimized',
cpuPlatform = 'Milan',
localSsd    = '1',
bandwidth   = '32',
spot        = '1'
WHERE name LIKE 'c2d-%';
UPDATE instances SET bandwidth = '10'  WHERE name LIKE 'c2d-%-2';
UPDATE instances SET bandwidth = '10'  WHERE name LIKE 'c2d-%-4';
UPDATE instances SET bandwidth = '16'  WHERE name LIKE 'c2d-%-8';
UPDATE instances SET tier1 = '50'  WHERE name LIKE 'c2d-%-32';
UPDATE instances SET tier1 = '50'  WHERE name LIKE 'c2d-%-56';
UPDATE instances SET tier1 = '100' WHERE name LIKE 'c2d-%-112';