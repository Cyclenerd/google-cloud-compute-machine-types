/* M3 Memory-optimized */
/* https://cloud.google.com/compute/docs/memory-optimized-machines#m4_series */
UPDATE instances SET
series      = 'm4',
family      = 'Memory-optimized',
cpuPlatform = 'Emerald Rapids',
localSsd    = '0',
bandwidth   = '32',
tier1       = '50',
sud         = '0',
spot        = '0'
WHERE name LIKE 'm4-%';
UPDATE instances SET bandwidth = '32',  tier1 = '50'  WHERE name LIKE 'm4-%-56';
UPDATE instances SET bandwidth = '50',  tier1 = '100' WHERE name LIKE 'm4-%-112';
UPDATE instances SET bandwidth = '100', tier1 = '200' WHERE name LIKE 'm4-%-224';

