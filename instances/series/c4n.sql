/* C4N Network-optimized machine family for Compute Engine */
/* https://docs.cloud.google.com/compute/docs/network-optimized-machines#c4n_series */
UPDATE instances SET
series      = 'c4n',
family      = 'Network-optimized',
cpuPlatform = 'Emerald Rapids',
localSsd    = '0',
sud         = '0',
spot        = '1'
WHERE name LIKE 'c4n-%';
UPDATE instances SET bandwidth = '25' WHERE name LIKE 'c4n-%-2%';
UPDATE instances SET bandwidth = '30' WHERE name LIKE 'c4n-%-4%';
UPDATE instances SET bandwidth = '40' WHERE name LIKE 'c4n-%-8%';
UPDATE instances SET bandwidth = '50' WHERE name LIKE 'c4n-%-16%';
UPDATE instances SET bandwidth = '50' WHERE name LIKE 'c4n-%-24%';
UPDATE instances SET bandwidth = '100' WHERE name LIKE 'c4n-%-48%';
UPDATE instances SET bandwidth = '200' WHERE name LIKE 'c4n-%-96%';
UPDATE instances SET bandwidth = '400' WHERE name LIKE 'c4n-%-192%';

UPDATE instances SET localSsd = '1' WHERE name LIKE 'c4n-%-lssd';