/* C4 General-purpose */
/* https://cloud.google.com/compute/docs/general-purpose-machines#c4_series */
UPDATE instances SET
series      = 'c4',
family      = 'General-purpose',
cpuPlatform = 'Emerald Rapids',
localSsd    = '0',
sud         = '0',
spot        = '1'
WHERE name LIKE 'c4-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'c4-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'c4-%-4';
UPDATE instances SET bandwidth = '23' WHERE name LIKE 'c4-%-8';
UPDATE instances SET bandwidth = '23' WHERE name LIKE 'c4-%-16';
UPDATE instances SET bandwidth = '23' WHERE name LIKE 'c4-%-32';
UPDATE instances SET bandwidth = '34' WHERE name LIKE 'c4-%-48';
UPDATE instances SET bandwidth = '67' WHERE name LIKE 'c4-%-96';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'c4-%-192';
