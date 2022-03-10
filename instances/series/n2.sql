/* N2 General-purpose */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#n2_machines */
UPDATE instances SET
series      = 'n2',
family      = 'Balanced',
cpuPlatform = 'Cascade Lake, Ice Lake',
localSsd    = '1',
sud         = '1',
spot        = '1'
WHERE name LIKE 'n2-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n2-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n2-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'n2-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n2-%-16';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'n2-%-32';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'n2-%-48';
UPDATE instances SET bandwidth = '32', tier1 = '75'  WHERE name LIKE 'n2-%-64';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2-%-80';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2-%-96';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2-%-128';