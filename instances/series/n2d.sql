/* N2D General-purpose */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#n2d_machines */
UPDATE instances SET
series      = 'n2d',
family      = 'Balanced',
cpuPlatform = 'Rome, Milan',
localSsd    = '1',
sud         = '1',
spot        = '1'
WHERE name LIKE 'n2d-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n2d-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n2d-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'n2d-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n2d-%-16';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n2d-%-32';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'n2d-%-48';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'n2d-%-64';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'n2d-%-80';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2d-%-96';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2d-%-128';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2d-%-224';