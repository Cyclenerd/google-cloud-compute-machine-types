/* N1 General-purpose */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#n1_machines */
UPDATE instances SET
series      = 'n1',
family      = 'Balanced',
intel       = 'true',
cpuPlatform = 'Skylake, Broadwell, Haswell, [Sandy Bridge], Ivy Bridge', cpuBaseClock  = '2.6', cpuTurboClock  = '3.2', cpuSingleMaxTurboClock = '3.6',
localSsd    = 'true',
sud         = 'true',
spot        = 'true'
WHERE name LIKE 'n1-%';
UPDATE instances SET bandwidth = '2'  WHERE name LIKE 'n1-%-1';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n1-%-2';
UPDATE instances SET bandwidth = '10' WHERE name LIKE 'n1-%-4';
UPDATE instances SET bandwidth = '16' WHERE name LIKE 'n1-%-8';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n1-%-16';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n1-%-32';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n1-%-64';
UPDATE instances SET bandwidth = '32' WHERE name LIKE 'n1-%-96';


/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */
/* Intel Skylake */
UPDATE instances SET coremarkScore = '20090',   standardDeviation = '2.47',  sampleCount = '79672' WHERE name LIKE 'n1-standard-1';
UPDATE instances SET coremarkScore = '26532',   standardDeviation = '3.28',  sampleCount = '82204' WHERE name LIKE 'n1-standard-2';
UPDATE instances SET coremarkScore = '54678',   standardDeviation = '3.1',   sampleCount = '81744' WHERE name LIKE 'n1-standard-4';
UPDATE instances SET coremarkScore = '105383',  standardDeviation = '3.22',  sampleCount = '79268' WHERE name LIKE 'n1-standard-8';
UPDATE instances SET coremarkScore = '221834',  standardDeviation = '2.18',  sampleCount = '67668' WHERE name LIKE 'n1-standard-16';
UPDATE instances SET coremarkScore = '440755',  standardDeviation = '2.13',  sampleCount = '36300' WHERE name LIKE 'n1-standard-32';
UPDATE instances SET coremarkScore = '883369',  standardDeviation = '1.67',  sampleCount = '18568' WHERE name LIKE 'n1-standard-64';
UPDATE instances SET coremarkScore = '1247197', standardDeviation = '1.4',   sampleCount = '8772'  WHERE name LIKE 'n1-standard-96';
UPDATE instances SET coremarkScore = '26438',   standardDeviation = '2.87',  sampleCount = '85084' WHERE name LIKE 'n1-highmem-2';
UPDATE instances SET coremarkScore = '54337',   standardDeviation = '2.66',  sampleCount = '84532' WHERE name LIKE 'n1-highmem-4';
UPDATE instances SET coremarkScore = '104640',  standardDeviation = '2.79',  sampleCount = '82608' WHERE name LIKE 'n1-highmem-8';
UPDATE instances SET coremarkScore = '220547',  standardDeviation = '2.37',  sampleCount = '70820' WHERE name LIKE 'n1-highmem-16';
UPDATE instances SET coremarkScore = '439129',  standardDeviation = '2.45',  sampleCount = '38340' WHERE name LIKE 'n1-highmem-32';
UPDATE instances SET coremarkScore = '879708',  standardDeviation = '1.75',  sampleCount = '19732' WHERE name LIKE 'n1-highmem-64';
UPDATE instances SET coremarkScore = '1248277', standardDeviation = '1.3',   sampleCount = '9644'  WHERE name LIKE 'n1-highmem-96';
UPDATE instances SET coremarkScore = '26517',   standardDeviation = '2.8',   sampleCount = '84520' WHERE name LIKE 'n1-highcpu-2';
UPDATE instances SET coremarkScore = '54676',   standardDeviation = '2.81',  sampleCount = '84564' WHERE name LIKE 'n1-highcpu-4';
UPDATE instances SET coremarkScore = '105053',  standardDeviation = '2.59',  sampleCount = '84324' WHERE name LIKE 'n1-highcpu-8';
UPDATE instances SET coremarkScore = '221443',  standardDeviation = '2.1',   sampleCount = '72496' WHERE name LIKE 'n1-highcpu-16';
UPDATE instances SET coremarkScore = '438006',  standardDeviation = '2.17',  sampleCount = '38764' WHERE name LIKE 'n1-highcpu-32';
UPDATE instances SET coremarkScore = '874912',  standardDeviation = '1.64',  sampleCount = '19184' WHERE name LIKE 'n1-highcpu-64';
UPDATE instances SET coremarkScore = '1245251', standardDeviation = '1.46',  sampleCount = '9235'  WHERE name LIKE 'n1-highcpu-96';

/* SAP certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-apps#sap-certified-vms */
/* Intel Broadwell or Intel Skylake */
UPDATE instances SET sap = 'true', saps = '2090'   WHERE name LIKE 'n1-highmem-2';
UPDATE instances SET sap = 'true', saps = '4180'   WHERE name LIKE 'n1-highmem-4';
UPDATE instances SET sap = 'true', saps = '8360'   WHERE name LIKE 'n1-highmem-8';
UPDATE instances SET sap = 'true', saps = '16720'  WHERE name LIKE 'n1-highmem-16';
UPDATE instances SET sap = 'true', saps = '33440'  WHERE name LIKE 'n1-highmem-32';
UPDATE instances SET sap = 'true', saps = '66880'  WHERE name LIKE 'n1-highmem-64';
UPDATE instances SET sap = 'true', saps = '100320' WHERE name LIKE 'n1-highmem-96';
UPDATE instances SET sap = 'true', saps = '8360'   WHERE name LIKE 'n1-standard-8';
UPDATE instances SET sap = 'true', saps = '16720'  WHERE name LIKE 'n1-standard-16';
UPDATE instances SET sap = 'true', saps = '33440'  WHERE name LIKE 'n1-standard-32';
UPDATE instances SET sap = 'true', saps = '66880'  WHERE name LIKE 'n1-standard-64';
UPDATE instances SET sap = 'true', saps = '100320' WHERE name LIKE 'n1-standard-96';

/* SAP HANA certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-hana#hana-cert-table-vms */
UPDATE instances SET hana = 'true' WHERE name LIKE 'n1-highmem-32';
UPDATE instances SET hana = 'true' WHERE name LIKE 'n1-highmem-64';
UPDATE instances SET hana = 'true' WHERE name LIKE 'n1-highmem-96';


/* N1 shared-core */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/general-purpose-machines#n1_machines */
UPDATE instances SET
series      = 'n1',
family      = 'Balanced',
intel       = 'true',
cpuPlatform = 'Skylake, Broadwell, Haswell, [Sandy Bridge], Ivy Bridge', cpuBaseClock  = '2.6', cpuTurboClock  = '3.2', cpuSingleMaxTurboClock = '3.6',
bandwidth   = '1',
sud         = 'true',
spot        = 'true'
WHERE name LIKE 'g1-%' OR name LIKE 'f1-%';

/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */
/* Intel Skylake */
UPDATE instances SET coremarkScore = '4111',    standardDeviation = '13.19', sampleCount = '82456' WHERE name LIKE 'f1-micro';
UPDATE instances SET coremarkScore = '10657',   standardDeviation = '12.09', sampleCount = '81152' WHERE name LIKE 'g1-small';