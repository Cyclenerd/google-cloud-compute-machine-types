/* E2 General-purpose */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types */
UPDATE instances SET
series      = 'e2',
family      = 'Cost-optimized',
intel       = 'true',
amd         = 'true',
cpuPlatform = 'Skylake, [Broadwell], Haswell, Rome', cpuBaseClock  = '2.2', cpuTurboClock  = '2.8', cpuSingleMaxTurboClock = '3.7',
spot        = 'true'
WHERE name LIKE 'e2-%';
UPDATE instances SET bandwidth = '4'  WHERE name LIKE 'e2-%-2';
UPDATE instances SET bandwidth = '8'  WHERE name LIKE 'e2-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'e2-%-8';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'e2-%-16';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'e2-%-32';

/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */
/* Intel Skylake */
UPDATE instances SET coremarkScore = '26973',  standardDeviation = '5.28', sampleCount = '8784' WHERE name LIKE 'e2-standard-2';
UPDATE instances SET coremarkScore = '55439',  standardDeviation = '4',    sampleCount = '8528' WHERE name LIKE 'e2-standard-4';
UPDATE instances SET coremarkScore = '106182', standardDeviation = '3.48', sampleCount = '8268' WHERE name LIKE 'e2-standard-8';
UPDATE instances SET coremarkScore = '222745', standardDeviation = '1.9',  sampleCount = '6424' WHERE name LIKE 'e2-standard-16';
UPDATE instances SET coremarkScore = '26821',  standardDeviation = '4.7',  sampleCount = '8824' WHERE name LIKE 'e2-highmem-2';
UPDATE instances SET coremarkScore = '55013',  standardDeviation = '3.79', sampleCount = '8396' WHERE name LIKE 'e2-highmem-4';
UPDATE instances SET coremarkScore = '106036', standardDeviation = '4.46', sampleCount = '8420' WHERE name LIKE 'e2-highmem-8';
UPDATE instances SET coremarkScore = '221311', standardDeviation = '2.5',  sampleCount = '6624' WHERE name LIKE 'e2-highmem-16';
UPDATE instances SET coremarkScore = '26904',  standardDeviation = '4.13', sampleCount = '8892' WHERE name LIKE 'e2-highcpu-2';
UPDATE instances SET coremarkScore = '55441',  standardDeviation = '3.73', sampleCount = '8460' WHERE name LIKE 'e2-highcpu-4';
UPDATE instances SET coremarkScore = '106100', standardDeviation = '3.31', sampleCount = '8380' WHERE name LIKE 'e2-highcpu-8';
UPDATE instances SET coremarkScore = '223077', standardDeviation = '2.12', sampleCount = '6452' WHERE name LIKE 'e2-highcpu-16';


/* E2 shared-core */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types */
UPDATE instances SET bandwidth = '1' WHERE name LIKE 'e2-micro';
UPDATE instances SET bandwidth = '2' WHERE name LIKE 'e2-small';
UPDATE instances SET bandwidth = '2' WHERE name LIKE 'e2-medium';

/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */
/* Intel Skylake */
UPDATE instances SET coremarkScore = '3333',  standardDeviation = '15.02', sampleCount = '8800' WHERE name LIKE 'e2-micro';
UPDATE instances SET coremarkScore = '6700',  standardDeviation = '7.6',   sampleCount = '8920' WHERE name LIKE 'e2-small';
UPDATE instances SET coremarkScore = '13663', standardDeviation = '6.16',  sampleCount = '8832' WHERE name LIKE 'e2-medium';