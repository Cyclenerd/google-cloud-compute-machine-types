/* Tau T2D General-purpose */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#t2d_machines */
UPDATE instances SET
series      = 't2d',
family      = 'Scale-out optimized',
amd         = 'true',
cpuPlatform = 'Milan', cpuBaseClock  = '2.45', cpuTurboClock  = '2.8', cpuSingleMaxTurboClock = '3.5',
spot        = 'true'
WHERE name LIKE 't2d-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 't2d-%-1';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 't2d-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 't2d-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 't2d-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2d-%-16';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2d-%-32';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2d-%-48';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 't2d-%-60';

/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */
/* AMD EPYC Milan */
UPDATE instances SET coremarkScore = '28961',   standardDeviation = '3.78', sampleCount = '1888' WHERE name LIKE 't2d-standard-1';
UPDATE instances SET coremarkScore = '58601',   standardDeviation = '3.64', sampleCount = '1888' WHERE name LIKE 't2d-standard-2';
UPDATE instances SET coremarkScore = '118761',  standardDeviation = '3.67', sampleCount = '1888' WHERE name LIKE 't2d-standard-4';
UPDATE instances SET coremarkScore = '229103',  standardDeviation = '3.78', sampleCount = '1876' WHERE name LIKE 't2d-standard-8';
UPDATE instances SET coremarkScore = '451682',  standardDeviation = '2.87', sampleCount = '1876' WHERE name LIKE 't2d-standard-16';
UPDATE instances SET coremarkScore = '886865',  standardDeviation = '1.69', sampleCount = '980'  WHERE name LIKE 't2d-standard-32';
UPDATE instances SET coremarkScore = '1305259', standardDeviation = '1.64', sampleCount = '672'  WHERE name LIKE 't2d-standard-48';
UPDATE instances SET coremarkScore = '1588850', standardDeviation = '1.2',  sampleCount = '672'  WHERE name LIKE 't2d-standard-60';

/* SAP certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-apps#sap-certified-vms */
/* T2D (AMD EPYC Milan) */
UPDATE instances SET sap = 'true', saps = '4325'   WHERE name LIKE 't2d-standard-2';
UPDATE instances SET sap = 'true', saps = '8650'   WHERE name LIKE 't2d-standard-4';
UPDATE instances SET sap = 'true', saps = '17300'  WHERE name LIKE 't2d-standard-8';
UPDATE instances SET sap = 'true', saps = '34600'  WHERE name LIKE 't2d-standard-16';
UPDATE instances SET sap = 'true', saps = '69200'  WHERE name LIKE 't2d-standard-32';
UPDATE instances SET sap = 'true', saps = '90064'  WHERE name LIKE 't2d-standard-48';
UPDATE instances SET sap = 'true', saps = '112580' WHERE name LIKE 't2d-standard-60';