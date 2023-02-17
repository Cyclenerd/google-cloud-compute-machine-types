/* C3 Compute-optimized */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* TODO: Check again if GA */
UPDATE instances SET
series      = 'c3',
family      = 'Compute-optimized',
cpuPlatform = 'Sapphire Rapids',
localSsd    = '1',
bandwidth   = '32',
spot        = '0'
WHERE name LIKE 'c3-%';
UPDATE instances SET tier1 = '200'  WHERE name LIKE 'c3-%';