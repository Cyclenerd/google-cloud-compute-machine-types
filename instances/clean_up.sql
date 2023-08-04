/* 
 * Delete not yet official 100% released machine types
 */

DELETE FROM machinetypes WHERE name LIKE 'c3-standard-%-lssd';
DELETE FROM machinetypes WHERE name LIKE 'h3-standard-%';

/* 
 * Delete not yet official 100% finished regions
 */

DELETE FROM machinetypes WHERE zone LIKE 'me-central2-%';
DELETE FROM disktypes    WHERE zone LIKE 'me-central2-%';

DELETE FROM machinetypes WHERE zone LIKE 'europe-west10-%';
DELETE FROM disktypes    WHERE zone LIKE 'europe-west10-%';

/*
DELETE FROM machinetypes WHERE zone LIKE 'me-central1-%';
DELETE FROM disktypes    WHERE zone LIKE 'me-central1-%';
*/

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