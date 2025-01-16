/* C4A General-purpose */
/* https://cloud.google.com/compute/docs/general-purpose-machines#c4a_series */
UPDATE instances SET
series      = 'c4a',
family      = 'General-purpose',
cpuPlatform = 'Google Axion',
localSsd    = '0',
sud         = '0',
spot        = '1'
WHERE name LIKE 'c4a-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'c4a-%-1%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'c4a-%-2%';
UPDATE instances SET bandwidth = '23' WHERE name LIKE 'c4a-%-4%';
UPDATE instances SET bandwidth = '23' WHERE name LIKE 'c4a-%-8%';
UPDATE instances SET bandwidth = '23' WHERE name LIKE 'c4a-%-16%';
UPDATE instances SET bandwidth = '23' WHERE name LIKE 'c4a-%-32%';
UPDATE instances SET bandwidth = '34' WHERE name LIKE 'c4a-%-48%';
UPDATE instances SET bandwidth = '45' WHERE name LIKE 'c4a-%-64%';
UPDATE instances SET bandwidth = '50' WHERE name LIKE 'c4a-%-72%';

UPDATE instances SET tier1 = '50'  WHERE name LIKE 'c4a-%-32%';
UPDATE instances SET tier1 = '50'  WHERE name LIKE 'c4a-%-48%';
UPDATE instances SET tier1 = '75'  WHERE name LIKE 'c4a-%-64%';
UPDATE instances SET tier1 = '100' WHERE name LIKE 'c4a-%-72%';

UPDATE instances SET localSsd = '1' WHERE name LIKE 'c4a-%-lssd';