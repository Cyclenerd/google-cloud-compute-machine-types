/* A4 Accelerator-optimized machine family */
/* https://cloud.google.com/compute/docs/accelerator-optimized-machines#a4-vms */
/* https://cloud.google.com/compute/docs/gpus#a4 */
UPDATE instances SET
series      = 'a4',
family      = 'Accelerator-optimized',
cpuPlatform = 'Sapphire Rapids',
localSsd    = '12000',
bandwidth   = '3600',
spot        = '1'
WHERE name LIKE 'a4-%';
