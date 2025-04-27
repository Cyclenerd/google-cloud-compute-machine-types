/* C4D General-purpose */
/* https://cloud.google.com/compute/docs/general-purpose-machines#c4d_machine_types */
UPDATE instances SET
series      = 'c4d',
family      = 'General-purpose',
cpuPlatform = 'Turin',
localSsd    = '0',
sud         = '0',
spot        = '1'
WHERE name LIKE 'c4d-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'c4d-%-2%';
UPDATE instances SET bandwidth = '20' WHERE name LIKE 'c4d-%-4%';
UPDATE instances SET bandwidth = '20' WHERE name LIKE 'c4d-%-8%';
UPDATE instances SET bandwidth = '20' WHERE name LIKE 'c4d-%-16%';
UPDATE instances SET bandwidth = '23' WHERE name LIKE 'c4d-%-32%';
UPDATE instances SET bandwidth = '34' WHERE name LIKE 'c4d-%-48%';
UPDATE instances SET bandwidth = '45' WHERE name LIKE 'c4d-%-64%';
UPDATE instances SET bandwidth = '67' WHERE name LIKE 'c4d-%-96%';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'c4d-%-192%';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'c4d-%-384%';

UPDATE instances SET tier1 = '50'  WHERE name LIKE 'c4d-%-48%';
UPDATE instances SET tier1 = '75'  WHERE name LIKE 'c4d-%-64%';
UPDATE instances SET tier1 = '100' WHERE name LIKE 'c4d-%-96%';
UPDATE instances SET tier1 = '150' WHERE name LIKE 'c4d-%-192%';
UPDATE instances SET tier1 = '200' WHERE name LIKE 'c4d-%-384%';
