/* N4A General-purpose */
/* https://docs.cloud.google.com/compute/docs/general-purpose-machines?hl=en#n4a_series */
UPDATE instances SET
series      = 'n4a',
family      = 'General-purpose',
cpuPlatform = 'Google Axion',
localSsd    = '0',
sud         = '0',
spot        = '1'
WHERE name LIKE 'n4a-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n4a-%-1';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n4a-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n4a-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'n4a-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n4a-%-16';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n4a-%-32';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n4a-%-48';
UPDATE instances SET bandwidth = '50' WHERE name LIKE 'n4a-%-64';
