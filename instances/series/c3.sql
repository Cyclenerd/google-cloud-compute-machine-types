/* C3 Compute-optimized */
/* https://cloud.google.com/compute/docs/general-purpose-machines#c3-standard_1 */
UPDATE instances SET
series      = 'c3',
family      = 'General-purpose',
cpuPlatform = 'Sapphire Rapids',
localSsd    = '0',
bandwidth   = '32',
spot        = '1'
WHERE name LIKE 'c3-%';

UPDATE instances SET bandwidth = '23'  WHERE name LIKE 'c3-%-4%';
UPDATE instances SET bandwidth = '23'  WHERE name LIKE 'c3-%-8%';
UPDATE instances SET bandwidth = '23'  WHERE name LIKE 'c3-%-22%';
UPDATE instances SET bandwidth = '32'  WHERE name LIKE 'c3-%-44%';
UPDATE instances SET bandwidth = '62'  WHERE name LIKE 'c3-%-88%';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'c3-%-176%';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'c3-%-192-metal%';

UPDATE instances SET tier1 = '50'  WHERE name LIKE 'c3-%-44%';
UPDATE instances SET tier1 = '100' WHERE name LIKE 'c3-%-88%';
UPDATE instances SET tier1 = '200' WHERE name LIKE 'c3-%-176%';
UPDATE instances SET tier1 = '200' WHERE name LIKE 'c3-%-192-metal%';

UPDATE instances SET localSsd = '1' WHERE name LIKE 'c3-%-lssd';