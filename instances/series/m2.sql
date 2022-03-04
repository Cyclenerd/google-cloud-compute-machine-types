/* M2 Memory-optimized ultramem */
/* https://cloud.google.com/compute/docs/machine-types#machine_type_comparison */
/* https://cloud.google.com/compute/docs/memory-optimized-machines#m2_machine_types */
UPDATE instances SET
series      = 'm2',
family      = 'Memory-optimized',
intel       = 'true',
cpuPlatform = 'Cascade Lake', cpuBaseClock  = '2.5', cpuTurboClock  = '3.4', cpuSingleMaxTurboClock = '4.0',
bandwidth   = '32',
sud         = 'true'
WHERE name LIKE 'm2-%';

/* SAP certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-apps#sap-certified-vms */
/* M2 (Intel Cascade Lake) */
UPDATE instances SET sap = 'true', saps = '223325' WHERE name LIKE 'm2-ultramem-208';
UPDATE instances SET sap = 'true', saps = '446650' WHERE name LIKE 'm2-ultramem-416';
UPDATE instances SET sap = 'true', saps = '446650' WHERE name LIKE 'm2-megamem-416';

/* SAP HANA certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-hana#hana-cert-table-vms */
UPDATE instances SET hana = 'true' WHERE name LIKE 'm2-%';