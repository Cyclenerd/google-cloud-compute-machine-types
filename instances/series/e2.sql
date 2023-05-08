/* E2 General-purpose */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types */
UPDATE instances SET
series      = 'e2',
family      = 'General-purpose',
cpuPlatform = 'Skylake, Broadwell, Haswell, Rome',
spot        = '1'
WHERE name LIKE 'e2-%';
UPDATE instances SET bandwidth = '4'  WHERE name LIKE 'e2-%-2';
UPDATE instances SET bandwidth = '8'  WHERE name LIKE 'e2-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'e2-%-8';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'e2-%-16';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'e2-%-32';

/* E2 shared-core */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types */
UPDATE instances SET bandwidth = '1' WHERE name LIKE 'e2-micro';
UPDATE instances SET bandwidth = '2' WHERE name LIKE 'e2-small';
UPDATE instances SET bandwidth = '2' WHERE name LIKE 'e2-medium';