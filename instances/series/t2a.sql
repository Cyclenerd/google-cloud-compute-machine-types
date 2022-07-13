/* Tau T2A General-purpose */
/* https://cloud.google.com/compute/docs/general-purpose-machines#t2a_machines */
UPDATE instances SET
series      = 't2a',
family      = 'Scale-out optimized',
cpuPlatform = 'Ampere Altra',
spot        = '1'
WHERE name LIKE 't2a-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 't2a-%-1';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 't2a-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 't2a-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 't2a-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2a-%-16';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2a-%-32';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2a-%-48';
