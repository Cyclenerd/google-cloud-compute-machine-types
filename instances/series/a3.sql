/* A3 Accelerator-optimized machine family */
/* https://cloud.google.com/compute/docs/accelerator-optimized-machines#a3-vms */
UPDATE instances SET
series      = 'a3',
family      = 'Accelerator-optimized',
cpuPlatform = 'Sapphire Rapids',
localSsd    = '1',
bandwidth   = '1000',
spot        = '0'
WHERE name LIKE 'a3-%';