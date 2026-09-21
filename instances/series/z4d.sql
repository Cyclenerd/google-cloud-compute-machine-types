/* Z4D Storage-optimized */
/* https://cloud.google.com/compute/docs/storage-optimized-machines */
UPDATE instances SET
series      = 'z4d',
family      = 'Storage-optimized',
cpuPlatform = 'Turin',
localSsd    = '1',
sud         = '0',
spot        = '1'
WHERE name LIKE 'z4d-%';

UPDATE instances SET bandwidth = '20'  WHERE name LIKE 'z4d-highmem-8%';
UPDATE instances SET bandwidth = '20'  WHERE name LIKE 'z4d-highmem-16%';
UPDATE instances SET bandwidth = '32'  WHERE name LIKE 'z4d-highmem-32%';
UPDATE instances SET bandwidth = '50'  WHERE name LIKE 'z4d-highmem-48%';
UPDATE instances SET bandwidth = '65'  WHERE name LIKE 'z4d-highmem-64%';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'z4d-highmem-96%';
UPDATE instances SET bandwidth = '200' WHERE name LIKE 'z4d-highmem-192%';
UPDATE instances SET bandwidth = '400' WHERE name LIKE 'z4d-highmem-384%';

UPDATE instances SET localSsd = '3500'  WHERE name LIKE 'z4d-highmem-16-standardlssd';
UPDATE instances SET localSsd = '7000'  WHERE name LIKE 'z4d-highmem-32-standardlssd';
UPDATE instances SET localSsd = '10500' WHERE name LIKE 'z4d-highmem-48-standardlssd';
UPDATE instances SET localSsd = '14000' WHERE name LIKE 'z4d-highmem-64-standardlssd';
UPDATE instances SET localSsd = '21000' WHERE name LIKE 'z4d-highmem-96-standardlssd';
UPDATE instances SET localSsd = '42000' WHERE name LIKE 'z4d-highmem-192-standardlssd';
UPDATE instances SET localSsd = '84000' WHERE name LIKE 'z4d-highmem-384-standardlssd';

UPDATE instances SET localSsd = '3500'  WHERE name LIKE 'z4d-highmem-8-highlssd';
UPDATE instances SET localSsd = '7000'  WHERE name LIKE 'z4d-highmem-16-highlssd';
UPDATE instances SET localSsd = '14000' WHERE name LIKE 'z4d-highmem-32-highlssd';
UPDATE instances SET localSsd = '21000' WHERE name LIKE 'z4d-highmem-48-highlssd';
UPDATE instances SET localSsd = '28000' WHERE name LIKE 'z4d-highmem-64-highlssd';
UPDATE instances SET localSsd = '42000' WHERE name LIKE 'z4d-highmem-96-highlssd';
UPDATE instances SET localSsd = '84000' WHERE name LIKE 'z4d-highmem-192-highlssd';
