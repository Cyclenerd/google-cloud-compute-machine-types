/* C2 Compute-optimized */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/compute-optimized-machines#c2_machine_types */
UPDATE instances SET
series      = 'c2',
family      = 'Compute-optimized',
cpuPlatform = 'Cascade Lake',
localSsd    = '1',
sud         = '1',
spot        = '1'
WHERE name LIKE 'c2-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'c2-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'c2-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'c2-%-16';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'c2-%-30';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'c2-%-60';