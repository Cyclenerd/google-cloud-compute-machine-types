/* Z3 Storage-optimized */
/* https://cloud.google.com/compute/docs/storage-optimized-machines */
UPDATE instances SET
series      = 'z3',
family      = 'Storage-optimized',
cpuPlatform = 'Sapphire Rapids',
localSsd    = '1',
spot        = '1'
WHERE name LIKE 'z3-%';

UPDATE instances SET bandwidth = '23' WHERE name LIKE 'z3-highmem-8%';
UPDATE instances SET bandwidth = '23' WHERE name LIKE 'z3-highmem-16%';
UPDATE instances SET bandwidth = '23' WHERE name LIKE 'z3-highmem-22%';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'z3-highmem-32%';
UPDATE instances SET bandwidth = '32'   tier1 = '50'  WHERE name LIKE 'z3-highmem-44%';
UPDATE instances SET bandwidth = '62',  tier1 = '100' WHERE name LIKE 'z3-highmem-88%';
UPDATE instances SET bandwidth = '100', tier1 = '200' WHERE name LIKE 'z3-highmem-176%';
UPDATE instances SET bandwidth = '100', tier1 = '200' WHERE name LIKE 'z3-highmem-192%';

UPDATE instances SET localSsd = '3000'  WHERE name LIKE 'z3-highmem-14-standardlssd';
UPDATE instances SET localSsd = '6000'  WHERE name LIKE 'z3-highmem-22-standardlssd';
UPDATE instances SET localSsd = '9000'  WHERE name LIKE 'z3-highmem-44-standardlssd';
UPDATE instances SET localSsd = '18000' WHERE name LIKE 'z3-highmem-88-standardlssd';
UPDATE instances SET localSsd = '36000' WHERE name LIKE 'z3-highmem-176-standardlssd';

UPDATE instances SET localSsd = '3000'  WHERE name LIKE 'z3-highmem-8-highlssd';
UPDATE instances SET localSsd = '6000'  WHERE name LIKE 'z3-highmem-16-highlssd';
UPDATE instances SET localSsd = '9000'  WHERE name LIKE 'z3-highmem-22-highlssd';
UPDATE instances SET localSsd = '12000' WHERE name LIKE 'z3-highmem-32-highlssd';
UPDATE instances SET localSsd = '18000' WHERE name LIKE 'z3-highmem-44-highlssd';
UPDATE instances SET localSsd = '36000' WHERE name LIKE 'z3-highmem-88-highlssd';
UPDATE instances SET localSsd = '72000' WHERE name LIKE 'z3-highmem-192-highlssd-metal';

