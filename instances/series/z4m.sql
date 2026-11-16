/* Z4M Storage-optimized */
/* https://cloud.google.com/compute/docs/storage-optimized-machines#z4m_machine_types */
/* Enrichment runs after pricing ingestion; clear unsupported price fallbacks. */
UPDATE instances SET
series      = 'z4m',
family      = 'Storage-optimized',
cpuPlatform = 'Emerald Rapids',
sud         = '0',
spot        = '1',
monthWindows = NULL
WHERE name LIKE 'z4m-%';

UPDATE instances SET bandwidth = '32',  localSsd = '14000'  WHERE name = 'z4m-highmem-16';
UPDATE instances SET bandwidth = '67',  localSsd = '28000'  WHERE name = 'z4m-highmem-32';
UPDATE instances SET bandwidth = '100', localSsd = '42000'  WHERE name = 'z4m-highmem-48';
UPDATE instances SET bandwidth = '400', localSsd = '168000' WHERE name = 'z4m-highmem-192';
UPDATE instances SET bandwidth = '400', localSsd = '168000', spot = '0', hourSpot = NULL, monthSpot = NULL WHERE name = 'z4m-highmem-192-metal';
