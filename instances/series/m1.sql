/* M1 Memory-optimized megamem */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/memory-optimized-machines#m1_machine_types */
UPDATE instances SET
series      = 'm1',
family      = 'Memory-optimized',
cpuPlatform = 'Skylake',
localSsd    = '1',
bandwidth   = '32',
sud         = '1',
spot        = '1'
WHERE name LIKE 'm1-megamem-%';

/* M1 Memory-optimized ultramem */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/memory-optimized-machines#m1_machine_types */
UPDATE instances SET
series      = 'm1',
family      = 'Memory-optimized',
cpuPlatform = 'Broadwell',
bandwidth   = '32',
sud         = '1',
spot        = '1'
WHERE name LIKE 'm1-ultramem-%';