/* C3 Compute-optimized */
/* https://cloud.google.com/compute/docs/general-purpose-machines#c3-standard_1 */
UPDATE instances SET
series      = 'c3d',
family      = 'General-purpose',
cpuPlatform = 'Genoa',
localSsd    = '0',
bandwidth   = '20',
spot        = '1'
WHERE name LIKE 'c3d-%';

UPDATE instances SET bandwidth = '40'  WHERE name LIKE 'c3d-%-60%';
UPDATE instances SET bandwidth = '60'  WHERE name LIKE 'c3d-%-90%';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'c3d-%-180%';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'c3d-%-360%';

UPDATE instances SET tier1 = '50'  WHERE name LIKE 'c3d-%-30%';
UPDATE instances SET tier1 = '75'  WHERE name LIKE 'c3d-%-60%';
UPDATE instances SET tier1 = '100' WHERE name LIKE 'c3d-%-90%';
UPDATE instances SET tier1 = '150' WHERE name LIKE 'c3d-%-180%';
UPDATE instances SET tier1 = '200' WHERE name LIKE 'c3d-%-360%';

UPDATE instances SET localSsd = '1' WHERE name LIKE 'c3d-%-lssd';