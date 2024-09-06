/* 
 * Delete not yet official 100% released machine types
 */

DELETE FROM machinetypes WHERE name LIKE 'ct3-%';
DELETE FROM machinetypes WHERE name LIKE 'ct3p-%';
DELETE FROM machinetypes WHERE name LIKE 'ct4p-%';
DELETE FROM machinetypes WHERE name LIKE 'ct5l-%';
DELETE FROM machinetypes WHERE name LIKE 'ct5lp-%';
DELETE FROM machinetypes WHERE name LIKE 'ct5p-%';

DELETE FROM machinetypes WHERE name LIKE 'x4-%';

/* https://github.com/Cyclenerd/google-cloud-compute-machine-types/issues/27 */
DELETE FROM machinetypes WHERE name LIKE 'a3-megagpu-%' AND region LIKE 'us-central1';
DELETE FROM machinetypes WHERE name LIKE 'a3-megagpu-%' AND region LIKE 'us-west1';

/* 
 * Delete not yet official 100% finished regions
 */

DELETE FROM machinetypes WHERE zone LIKE 'northamerica-south1-%';
DELETE FROM disktypes    WHERE zone LIKE 'northamerica-south1-%';

DELETE FROM machinetypes WHERE zone LIKE 'us-west8-%';
DELETE FROM disktypes    WHERE zone LIKE 'us-west8-%';


/*
 * Remove disconnected data centers
 */
/* us-central2 */
DELETE FROM machinetypes WHERE zone LIKE 'us-central2-%';
DELETE FROM disktypes    WHERE zone LIKE 'us-central2-%';
/* us-east2 */
DELETE FROM machinetypes WHERE zone LIKE 'us-east2-%';
DELETE FROM disktypes    WHERE zone LIKE 'us-east2-%';
/* us-east7 */
DELETE FROM machinetypes WHERE zone LIKE 'us-east7-%';
DELETE FROM disktypes    WHERE zone LIKE 'us-east7-%';
/* europe-west5 */
DELETE FROM machinetypes WHERE zone LIKE 'europe-west5-%';
DELETE FROM disktypes    WHERE zone LIKE 'europe-west5-%';