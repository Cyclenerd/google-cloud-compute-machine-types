/* N1 General-purpose */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#n1_machines */
UPDATE instances SET
series      = 'n1',
family      = 'General-purpose',
cpuPlatform = 'Skylake, Broadwell, Haswell, Sandy Bridge, Ivy Bridge',
localSsd    = '1',
sud         = '1',
spot        = '1'
WHERE name LIKE 'n1-%';
UPDATE instances SET bandwidth = '2'  WHERE name LIKE 'n1-%-1';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n1-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n1-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'n1-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n1-%-16';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n1-%-32';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n1-%-64';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n1-%-96';

/* N1 shared-core */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#n1_machines */
UPDATE instances SET
series      = 'n1',
family      = 'Balanced',
cpuPlatform = 'Skylake, Broadwell, Haswell, Sandy Bridge, Ivy Bridge',
bandwidth   = '1',
sud         = '1',
spot        = '1'
WHERE name LIKE 'g1-%' OR name LIKE 'f1-%';