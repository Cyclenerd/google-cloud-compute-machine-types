/* C2 Compute-optimized */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/compute-optimized-machines#c2_machine_types */
UPDATE instances SET
series      = 'c2',
family      = 'Compute-optimized',
intel       = 'true',
cpuPlatform = 'Cascade Lake', cpuBaseClock  = '3.1', cpuTurboClock  = '3.8', cpuSingleMaxTurboClock = '3.9',
localSsd    = 'true',
sud         = 'true',
spot        = 'true'
WHERE name LIKE 'c2-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'c2-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'c2-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'c2-%-16';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'c2-%-30';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'c2-%-60';

/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */
/* Intel Cascade Lake */
UPDATE instances SET coremarkScore = '77310',   standardDeviation = '1.15', sampleCount = '7035' WHERE name LIKE 'c2-standard-4';
UPDATE instances SET coremarkScore = '148689',  standardDeviation = '1.22', sampleCount = '4828' WHERE name LIKE 'c2-standard-8';
UPDATE instances SET coremarkScore = '313768',  standardDeviation = '1.32', sampleCount = '4292' WHERE name LIKE 'c2-standard-16';
UPDATE instances SET coremarkScore = '571147',  standardDeviation = '1.86', sampleCount = '2467' WHERE name LIKE 'c2-standard-30';
UPDATE instances SET coremarkScore = '1142234', standardDeviation = '1.51', sampleCount = '1535' WHERE name LIKE 'c2-standard-60';

/* SAP certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-apps#sap-certified-vms */
/* C2 (Intel Cascade Lake) */
UPDATE instances SET sap = 'true', saps = '6040'  WHERE name LIKE 'c2-standard-4';
UPDATE instances SET sap = 'true', saps = '12080' WHERE name LIKE 'c2-standard-8';
UPDATE instances SET sap = 'true', saps = '24160' WHERE name LIKE 'c2-standard-16';
UPDATE instances SET sap = 'true', saps = '45300' WHERE name LIKE 'c2-standard-30';
UPDATE instances SET sap = 'true', saps = '90600' WHERE name LIKE 'c2-standard-60';