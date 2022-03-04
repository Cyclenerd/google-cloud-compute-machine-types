/* C2D Compute-optimized */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/compute-optimized-machines#c2d-standard */
UPDATE instances SET
series      = 'c2d',
family      = 'Compute-optimized',
amd         = 'true',
cpuPlatform = 'Milan', cpuBaseClock  = '2.45', cpuTurboClock  = '2.8', cpuSingleMaxTurboClock = '3.5',
localSsd    = 'true',
bandwidth   = '32',
spot        = 'true'
WHERE name LIKE 'c2d-%';
UPDATE instances SET tier1 = '50'  WHERE name LIKE 'c2d-%-32';
UPDATE instances SET tier1 = '50'  WHERE name LIKE 'c2d-%-56';
UPDATE instances SET tier1 = '100' WHERE name LIKE 'c2d-%-112';

/* SAP certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-apps#sap-certified-vms */
/* C2D (AMD EPYC Milan) */
UPDATE instances SET sap = 'true', saps = '3543'   WHERE name LIKE 'c2d-highmem-2';
UPDATE instances SET sap = 'true', saps = '7086'   WHERE name LIKE 'c2d-highmem-4';
UPDATE instances SET sap = 'true', saps = '14171'  WHERE name LIKE 'c2d-highmem-8';
UPDATE instances SET sap = 'true', saps = '28343'  WHERE name LIKE 'c2d-highmem-16';
UPDATE instances SET sap = 'true', saps = '56686'  WHERE name LIKE 'c2d-highmem-32';
UPDATE instances SET sap = 'true', saps = '99200'  WHERE name LIKE 'c2d-highmem-56';
UPDATE instances SET sap = 'true', saps = '190150' WHERE name LIKE 'c2d-highmem-112';
UPDATE instances SET sap = 'true', saps = '3545'   WHERE name LIKE 'c2d-standard-2';
UPDATE instances SET sap = 'true', saps = '7089'   WHERE name LIKE 'c2d-standard-4';
UPDATE instances SET sap = 'true', saps = '14179'  WHERE name LIKE 'c2d-standard-8';
UPDATE instances SET sap = 'true', saps = '28357'  WHERE name LIKE 'c2d-standard-16';
UPDATE instances SET sap = 'true', saps = '56714'  WHERE name LIKE 'c2d-standard-32';
UPDATE instances SET sap = 'true', saps = '99250'  WHERE name LIKE 'c2d-standard-56';
UPDATE instances SET sap = 'true', saps = '189400' WHERE name LIKE 'c2d-standard-112';