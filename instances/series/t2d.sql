/* Tau T2D General-purpose */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#t2d_machines */
UPDATE instances SET
series      = 't2d',
family      = 'General-purpose',
cpuPlatform = 'Milan',
spot        = '1'
WHERE name LIKE 't2d-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 't2d-%-1';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 't2d-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 't2d-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 't2d-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2d-%-16';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2d-%-32';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2d-%-48';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2d-%-60';