/* H3 Compute-optimized */
/* https://cloud.google.com/compute/docs/compute-optimized-machines#h3_series */
UPDATE instances SET
series      = 'h3',
family      = 'Compute-optimized',
cpuPlatform = 'Sapphire Rapids',
localSsd    = '0',
bandwidth   = '200',
spot        = '0'
WHERE name LIKE 'h3-%';