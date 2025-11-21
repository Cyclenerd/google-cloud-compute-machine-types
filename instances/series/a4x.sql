/* A4X Accelerator-optimized machine family */
/* https://cloud.google.com/compute/docs/accelerator-optimized-machines#a4x-vms */
/* https://cloud.google.com/compute/docs/gpus#gb200-gpus */
UPDATE instances SET
series      = 'a4x',
family      = 'Accelerator-optimized',
cpuPlatform = 'ARM Neoverse V2',
localSsd    = '12000',
bandwidth   = '2000',
arm         = '1',
spot        = '1'
WHERE name LIKE 'a4x-%';
