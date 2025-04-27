/* SAP HANA certified machine types */
/* https://cloud.google.com/solutions/sap/docs/certifications-sap-hana#hana-cert-table-vms */

UPDATE instances SET hana = '1' WHERE name LIKE 'c3-highmem-88';
UPDATE instances SET hana = '1' WHERE name LIKE 'c3-standard-44';
UPDATE instances SET hana = '1' WHERE name LIKE 'c3-highmem-44';
UPDATE instances SET hana = '1' WHERE name LIKE 'c3-highmem-88';
UPDATE instances SET hana = '1' WHERE name LIKE 'c3-highmem-176';
UPDATE instances SET hana = '1' WHERE name LIKE 'c3-highmem-192-metal';

UPDATE instances SET hana = '1' WHERE name LIKE 'c4-highmem-32';
UPDATE instances SET hana = '1' WHERE name LIKE 'c4-highmem-48';
UPDATE instances SET hana = '1' WHERE name LIKE 'c4-highmem-96';
UPDATE instances SET hana = '1' WHERE name LIKE 'c4-highmem-192';

UPDATE instances SET hana = '1' WHERE name LIKE 'n1-highmem-32';
UPDATE instances SET hana = '1' WHERE name LIKE 'n1-highmem-64';
UPDATE instances SET hana = '1' WHERE name LIKE 'n1-highmem-96';

UPDATE instances SET hana = '1' WHERE name LIKE 'n2-highmem-32';
UPDATE instances SET hana = '1' WHERE name LIKE 'n2-highmem-48';
UPDATE instances SET hana = '1' WHERE name LIKE 'n2-highmem-64';
UPDATE instances SET hana = '1' WHERE name LIKE 'n2-highmem-80';
UPDATE instances SET hana = '1' WHERE name LIKE 'n2-highmem-96';
UPDATE instances SET hana = '1' WHERE name LIKE 'n2-highmem-128';

UPDATE instances SET hana = '1' WHERE name LIKE 'm1-%';

UPDATE instances SET hana = '1' WHERE name LIKE 'm2-%';

UPDATE instances SET hana = '1' WHERE name LIKE 'm3-%';

UPDATE instances SET hana = '1' WHERE name LIKE 'm4-%';