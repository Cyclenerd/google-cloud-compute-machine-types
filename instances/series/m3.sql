/* M3 Memory-optimized */
/* https://cloud.google.com/compute/docs/memory-optimized-machines#m3_machine_types */
UPDATE instances SET
series      = 'm3',
family      = 'Memory-optimized',
cpuPlatform = 'Ice Lake',
localSsd    = '1',
bandwidth   = '32',
sud         = '1',
spot        = '1'
WHERE name LIKE 'm3-%';
UPDATE instances SET tier1 = '50'  WHERE name LIKE 'm3-%-64';
UPDATE instances SET tier1 = '100' WHERE name LIKE 'm3-%-128';