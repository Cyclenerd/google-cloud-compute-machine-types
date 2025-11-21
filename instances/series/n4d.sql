/* N4 General-purpose */
/* https://cloud.google.com/compute/docs/general-purpose-machines#n4_series */
UPDATE instances SET
series      = 'n4d',
family      = 'General-purpose',
cpuPlatform = 'Turin',
localSsd    = '0',
sud         = '0',
spot        = '1'
WHERE name LIKE 'n4d-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n4d-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n4d-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'n4d-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n4d-%-16';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n4d-%-32';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n4d-%-48';
UPDATE instances SET bandwidth = '45' WHERE name LIKE 'n4d-%-64';
UPDATE instances SET bandwidth = '50' WHERE name LIKE 'n4d-%-80';
UPDATE instances SET bandwidth = '50' WHERE name LIKE 'n4d-%-96';
