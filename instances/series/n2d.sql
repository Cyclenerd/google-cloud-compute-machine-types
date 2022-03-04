/* N2D General-purpose */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#n2d_machines */
UPDATE instances SET
series      = 'n2d',
family      = 'Balanced',
amd         = 'true',
cpuPlatform = 'Rome, [Milan]', cpuBaseClock  = '2.45', cpuTurboClock  = '2.8', cpuSingleMaxTurboClock = '3.5',
localSsd    = 'true',
sud         = 'true',
spot        = 'true'
WHERE name LIKE 'n2d-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n2d-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n2d-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'n2d-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n2d-%-16';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n2d-%-32';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'n2d-%-48';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'n2d-%-64';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'n2d-%-80';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2d-%-96';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2d-%-128';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2d-%-224';

/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */
/* AMD EPYC Rome */
UPDATE instances SET coremarkScore = '34396',   standardDeviation = '1.35', sampleCount = '2696' WHERE name LIKE 'n2d-standard-2';
UPDATE instances SET coremarkScore = '71010',   standardDeviation = '1.71', sampleCount = '2704' WHERE name LIKE 'n2d-standard-4';
UPDATE instances SET coremarkScore = '134830',  standardDeviation = '1.07', sampleCount = '2688' WHERE name LIKE 'n2d-standard-8';
UPDATE instances SET coremarkScore = '279707',  standardDeviation = '1.78', sampleCount = '2288' WHERE name LIKE 'n2d-standard-16';
UPDATE instances SET coremarkScore = '563625',  standardDeviation = '2.12', sampleCount = '1288' WHERE name LIKE 'n2d-standard-32';
UPDATE instances SET coremarkScore = '843772',  standardDeviation = '2.67', sampleCount = '884'  WHERE name LIKE 'n2d-standard-48';
UPDATE instances SET coremarkScore = '1127574', standardDeviation = '1.14', sampleCount = '656'  WHERE name LIKE 'n2d-standard-64';
UPDATE instances SET coremarkScore = '1419027', standardDeviation = '1.39', sampleCount = '600'  WHERE name LIKE 'n2d-standard-80';
UPDATE instances SET coremarkScore = '1697951', standardDeviation = '1.48', sampleCount = '484'  WHERE name LIKE 'n2d-standard-96';
UPDATE instances SET coremarkScore = '2251019', standardDeviation = '1.54', sampleCount = '336'  WHERE name LIKE 'n2d-standard-128';
UPDATE instances SET coremarkScore = '3565048', standardDeviation = '2.8',  sampleCount = '200'  WHERE name LIKE 'n2d-standard-224';
UPDATE instances SET coremarkScore = '34300',   standardDeviation = '2.05', sampleCount = '2720' WHERE name LIKE 'n2d-highmem-2';
UPDATE instances SET coremarkScore = '70856',   standardDeviation = '2.36', sampleCount = '2692' WHERE name LIKE 'n2d-highmem-4';
UPDATE instances SET coremarkScore = '134588',  standardDeviation = '2.22', sampleCount = '2636' WHERE name LIKE 'n2d-highmem-8';
UPDATE instances SET coremarkScore = '279074',  standardDeviation = '2.29', sampleCount = '2308' WHERE name LIKE 'n2d-highmem-16';
UPDATE instances SET coremarkScore = '559560',  standardDeviation = '3.61', sampleCount = '1268' WHERE name LIKE 'n2d-highmem-32';
UPDATE instances SET coremarkScore = '838812',  standardDeviation = '3.73', sampleCount = '872'  WHERE name LIKE 'n2d-highmem-48';
UPDATE instances SET coremarkScore = '1119911', standardDeviation = '2.87', sampleCount = '660'  WHERE name LIKE 'n2d-highmem-64';
UPDATE instances SET coremarkScore = '1405243', standardDeviation = '2.92', sampleCount = '628'  WHERE name LIKE 'n2d-highmem-80';
UPDATE instances SET coremarkScore = '1674010', standardDeviation = '3.99', sampleCount = '472'  WHERE name LIKE 'n2d-highmem-96';
UPDATE instances SET coremarkScore = '34353',   standardDeviation = '1.01', sampleCount = '2716' WHERE name LIKE 'n2d-highcpu-2';
UPDATE instances SET coremarkScore = '71014',   standardDeviation = '1.44', sampleCount = '2692' WHERE name LIKE 'n2d-highcpu-4';
UPDATE instances SET coremarkScore = '134982',  standardDeviation = '0.77', sampleCount = '2636' WHERE name LIKE 'n2d-highcpu-8';
UPDATE instances SET coremarkScore = '279474',  standardDeviation = '1.19', sampleCount = '2312' WHERE name LIKE 'n2d-highcpu-16';
UPDATE instances SET coremarkScore = '564253',  standardDeviation = '1.78', sampleCount = '1272' WHERE name LIKE 'n2d-highcpu-32';
UPDATE instances SET coremarkScore = '845445',  standardDeviation = '1.73', sampleCount = '852'  WHERE name LIKE 'n2d-highcpu-48';
UPDATE instances SET coremarkScore = '1127676', standardDeviation = '1.2',  sampleCount = '648'  WHERE name LIKE 'n2d-highcpu-64';
UPDATE instances SET coremarkScore = '1416904', standardDeviation = '1.75', sampleCount = '596'  WHERE name LIKE 'n2d-highcpu-80';
UPDATE instances SET coremarkScore = '1690038', standardDeviation = '2.43', sampleCount = '468'  WHERE name LIKE 'n2d-highcpu-96';

/* SAP certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-apps#sap-certified-vms */
/* N2D (AMD EPYC Milan) */
UPDATE instances SET sap = 'true', saps = '3160'   WHERE name LIKE 'n2d-highmem-2';
UPDATE instances SET sap = 'true', saps = '6321'   WHERE name LIKE 'n2d-highmem-4';
UPDATE instances SET sap = 'true', saps = '12641'  WHERE name LIKE 'n2d-highmem-8';
UPDATE instances SET sap = 'true', saps = '25283'  WHERE name LIKE 'n2d-highmem-16';
UPDATE instances SET sap = 'true', saps = '50565'  WHERE name LIKE 'n2d-highmem-32';
UPDATE instances SET sap = 'true', saps = '75848'  WHERE name LIKE 'n2d-highmem-48';
UPDATE instances SET sap = 'true', saps = '101130' WHERE name LIKE 'n2d-highmem-64';
UPDATE instances SET sap = 'true', saps = '121108' WHERE name LIKE 'n2d-highmem-80';
UPDATE instances SET sap = 'true', saps = '145330' WHERE name LIKE 'n2d-highmem-96';
UPDATE instances SET sap = 'true', saps = '3166'   WHERE name LIKE 'n2d-standard-2';
UPDATE instances SET sap = 'true', saps = '6333'   WHERE name LIKE 'n2d-standard-4';
UPDATE instances SET sap = 'true', saps = '12665'  WHERE name LIKE 'n2d-standard-8';
UPDATE instances SET sap = 'true', saps = '25330'  WHERE name LIKE 'n2d-standard-16';
UPDATE instances SET sap = 'true', saps = '50660'  WHERE name LIKE 'n2d-standard-32';
UPDATE instances SET sap = 'true', saps = '75990'  WHERE name LIKE 'n2d-standard-48';
UPDATE instances SET sap = 'true', saps = '101320' WHERE name LIKE 'n2d-standard-64';
UPDATE instances SET sap = 'true', saps = '120833' WHERE name LIKE 'n2d-standard-80';
UPDATE instances SET sap = 'true', saps = '145000' WHERE name LIKE 'n2d-standard-96';
UPDATE instances SET sap = 'true', saps = '185950' WHERE name LIKE 'n2d-standard-128';
UPDATE instances SET sap = 'true', saps = '272600' WHERE name LIKE 'n2d-standard-224';