/* M2 Memory-optimized ultramem */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/memory-optimized-machines#m2_machine_types */
UPDATE instances SET
series      = 'm2',
family      = 'Memory-optimized',
cpuPlatform = 'Cascade Lake',
bandwidth   = '32',
sud         = '1'
WHERE name LIKE 'm2-%';