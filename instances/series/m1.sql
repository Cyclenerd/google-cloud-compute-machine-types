/* M1 Memory-optimized megamem */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/memory-optimized-machines#m1_machine_types */
UPDATE instances SET
series      = 'm1',
family      = 'Memory-optimized',
intel       = 'true',
cpuPlatform = 'Skylake', cpuBaseClock  = '2.0', cpuTurboClock  = '2.7', cpuSingleMaxTurboClock = '3.5',
localSsd    = 'true',
bandwidth   = '32',
sud         = 'true',
spot        = 'true'
WHERE name LIKE 'm1-megamem-%';

/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */
/* Intel Skylake*/
UPDATE instances SET coremarkScore = '1254891', standardDeviation = '1.11', sampleCount = '2852' WHERE name LIKE 'm1-megamem-96';


/* M1 Memory-optimized ultramem */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/memory-optimized-machines#m1_machine_types */
UPDATE instances SET
series      = 'm1',
family      = 'Memory-optimized',
intel       = 'true',
cpuPlatform = 'Broadwell E7', cpuBaseClock  = '2.2', cpuTurboClock  = '2.6', cpuSingleMaxTurboClock = '3.7',
bandwidth   = '32',
sud         = 'true',
spot        = 'true'
WHERE name LIKE 'm1-ultramem-%';

/* Benchmarks for Linux VM instances */
/* https://cloud.google.com/compute/docs/benchmarks-linux */
/* Intel Broadwell */
UPDATE instances SET coremarkScore = '498947',  standardDeviation = '0.5',  sampleCount = '8431' WHERE name LIKE 'm1-ultramem-40';
UPDATE instances SET coremarkScore = '994301',  standardDeviation = '0.76', sampleCount = '4412' WHERE name LIKE 'm1-ultramem-80';
UPDATE instances SET coremarkScore = '1967211', standardDeviation = '0.59', sampleCount = '2092' WHERE name LIKE 'm1-ultramem-160';

/* SAP certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-apps#sap-certified-vms */
/* M1 (Intel Broadwell or Intel Skylake) */
UPDATE instances SET sap = 'true', saps = '105050' WHERE name LIKE 'm1-megamem-96';
UPDATE instances SET sap = 'true', saps = '34475'  WHERE name LIKE 'm1-ultramem-40';
UPDATE instances SET sap = 'true', saps = '68950'  WHERE name LIKE 'm1-ultramem-80';
UPDATE instances SET sap = 'true', saps = '137900' WHERE name LIKE 'm1-ultramem-160';

/* SAP HANA certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-hana#hana-cert-table-vms */
UPDATE instances SET hana = 'true' WHERE name LIKE 'm1-%';