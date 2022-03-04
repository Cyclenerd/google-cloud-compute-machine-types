/* N2 General-purpose */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#n2_machines */
UPDATE instances SET
series      = 'n2',
family      = 'Balanced',
intel       = 'true',
cpuPlatform = 'Cascade Lake, [Ice Lake]', cpuBaseClock  = '2.6', cpuTurboClock  = '3.1', cpuSingleMaxTurboClock = '3.4',
localSsd    = 'true',
sud         = 'true',
spot        = 'true'
WHERE name LIKE 'n2-%';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n2-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n2-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'n2-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n2-%-16';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'n2-%-32';
UPDATE instances SET bandwidth = '32', tier1 = '50'  WHERE name LIKE 'n2-%-48';
UPDATE instances SET bandwidth = '32', tier1 = '75'  WHERE name LIKE 'n2-%-64';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2-%-80';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2-%-96';
UPDATE instances SET bandwidth = '32', tier1 = '100' WHERE name LIKE 'n2-%-128';

/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */
/* Intel Cascade Lake */
UPDATE instances SET coremarkScore = '69020',   standardDeviation = '0.83', sampleCount = '6131' WHERE name LIKE 'n2-standard-4';
UPDATE instances SET coremarkScore = '132589',  standardDeviation = '1.27', sampleCount = '6078' WHERE name LIKE 'n2-standard-8';
UPDATE instances SET coremarkScore = '279070',  standardDeviation = '1.19', sampleCount = '5410' WHERE name LIKE 'n2-standard-16';
UPDATE instances SET coremarkScore = '558589',  standardDeviation = '0.8',  sampleCount = '3028' WHERE name LIKE 'n2-standard-32';
UPDATE instances SET coremarkScore = '833947',  standardDeviation = '1.11', sampleCount = '2064' WHERE name LIKE 'n2-standard-48';
UPDATE instances SET coremarkScore = '1109876', standardDeviation = '1.11', sampleCount = '1568' WHERE name LIKE 'n2-standard-64';
UPDATE instances SET coremarkScore = '1288406', standardDeviation = '1.81', sampleCount = '1456' WHERE name LIKE 'n2-standard-80';
UPDATE instances SET coremarkScore = '33471',   standardDeviation = '0.68', sampleCount = '6069' WHERE name LIKE 'n2-highmem-2';
UPDATE instances SET coremarkScore = '68947',   standardDeviation = '1.02', sampleCount = '6102' WHERE name LIKE 'n2-highmem-4';
UPDATE instances SET coremarkScore = '132537',  standardDeviation = '1.08', sampleCount = '6124' WHERE name LIKE 'n2-highmem-8';
UPDATE instances SET coremarkScore = '278475',  standardDeviation = '1.17', sampleCount = '5411' WHERE name LIKE 'n2-highmem-16';
UPDATE instances SET coremarkScore = '558380',  standardDeviation = '0.87', sampleCount = '2996' WHERE name LIKE 'n2-highmem-32';
UPDATE instances SET coremarkScore = '831927',  standardDeviation = '1.45', sampleCount = '2077' WHERE name LIKE 'n2-highmem-48';
UPDATE instances SET coremarkScore = '1109925', standardDeviation = '1.09', sampleCount = '1566' WHERE name LIKE 'n2-highmem-64';
UPDATE instances SET coremarkScore = '1283110', standardDeviation = '1.85', sampleCount = '1480' WHERE name LIKE 'n2-highmem-80';
UPDATE instances SET coremarkScore = '33486',   standardDeviation = '0.52', sampleCount = '6061' WHERE name LIKE 'n2-highcpu-2';
UPDATE instances SET coremarkScore = '68980',   standardDeviation = '1.01', sampleCount = '6117' WHERE name LIKE 'n2-highcpu-4';
UPDATE instances SET coremarkScore = '132614',  standardDeviation = '0.96', sampleCount = '6037' WHERE name LIKE 'n2-highcpu-8';
UPDATE instances SET coremarkScore = '279395',  standardDeviation = '0.88', sampleCount = '5450' WHERE name LIKE 'n2-highcpu-16';
UPDATE instances SET coremarkScore = '558827',  standardDeviation = '0.9',  sampleCount = '2987' WHERE name LIKE 'n2-highcpu-32';
UPDATE instances SET coremarkScore = '835427',  standardDeviation = '1.16', sampleCount = '2057' WHERE name LIKE 'n2-highcpu-48';
UPDATE instances SET coremarkScore = '1110895', standardDeviation = '0.83', sampleCount = '1585' WHERE name LIKE 'n2-highcpu-64';
UPDATE instances SET coremarkScore = '1289988', standardDeviation = '1.8',  sampleCount = '1457' WHERE name LIKE 'n2-highcpu-80';

/* SAP certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-apps#sap-certified-vms */
/* N2 (Intel Ice Lake) */
UPDATE instances SET sap = 'true', saps = '3574'   WHERE name LIKE 'n2-highmem-2';
UPDATE instances SET sap = 'true', saps = '7148'   WHERE name LIKE 'n2-highmem-4';
UPDATE instances SET sap = 'true', saps = '14296'  WHERE name LIKE 'n2-highmem-8';
UPDATE instances SET sap = 'true', saps = '28593'  WHERE name LIKE 'n2-highmem-16';
UPDATE instances SET sap = 'true', saps = '57185'  WHERE name LIKE 'n2-highmem-32';
UPDATE instances SET sap = 'true', saps = '85778'  WHERE name LIKE 'n2-highmem-48';
UPDATE instances SET sap = 'true', saps = '114370' WHERE name LIKE 'n2-highmem-64';
UPDATE instances SET sap = 'true', saps = '133400' WHERE name LIKE 'n2-highmem-80';
UPDATE instances SET sap = 'true', saps = '160080' WHERE name LIKE 'n2-highmem-96';
UPDATE instances SET sap = 'true', saps = '183350' WHERE name LIKE 'n2-highmem-128';
UPDATE instances SET sap = 'true', saps = '3576'   WHERE name LIKE 'n2-standard-2';
UPDATE instances SET sap = 'true', saps = '7152'   WHERE name LIKE 'n2-standard-4';
UPDATE instances SET sap = 'true', saps = '14304'  WHERE name LIKE 'n2-standard-8';
UPDATE instances SET sap = 'true', saps = '28608'  WHERE name LIKE 'n2-standard-16';
UPDATE instances SET sap = 'true', saps = '57215'  WHERE name LIKE 'n2-standard-32';
UPDATE instances SET sap = 'true', saps = '85823'  WHERE name LIKE 'n2-standard-48';
UPDATE instances SET sap = 'true', saps = '114430' WHERE name LIKE 'n2-standard-64';
UPDATE instances SET sap = 'true', saps = '133183' WHERE name LIKE 'n2-standard-80';
UPDATE instances SET sap = 'true', saps = '159820' WHERE name LIKE 'n2-standard-96';
UPDATE instances SET sap = 'true', saps = '183900' WHERE name LIKE 'n2-standard-128';

/* SAP HANA certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-hana#hana-cert-table-vms */
UPDATE instances SET hana = 'true' WHERE name LIKE 'n2-highmem-32';
UPDATE instances SET hana = 'true' WHERE name LIKE 'n2-highmem-48';
UPDATE instances SET hana = 'true' WHERE name LIKE 'n2-highmem-64';
UPDATE instances SET hana = 'true' WHERE name LIKE 'n2-highmem-80';
UPDATE instances SET hana = 'true' WHERE name LIKE 'n2-highmem-96';
UPDATE instances SET hana = 'true' WHERE name LIKE 'n2-highmem-128';