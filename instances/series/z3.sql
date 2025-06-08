/* Z3 Storage-optimized */
/* https://cloud.google.com/compute/docs/storage-optimized-machines */
UPDATE instances SET
series      = 'z3',
family      = 'Storage-optimized',
cpuPlatform = 'Sapphire Rapids',
localSsd    = '36000',
spot        = '1'
WHERE name LIKE 'z3-%';

UPDATE instances SET bandwidth = '62',  tier1 = '100' WHERE name LIKE 'z3-highmem-88%';
UPDATE instances SET bandwidth = '100', tier1 = '200' WHERE name LIKE 'z3-highmem-176%';