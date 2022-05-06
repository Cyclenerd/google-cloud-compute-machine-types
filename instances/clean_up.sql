/* 
 * Delete not yet official 100% finished regions
 */

/* 2022/04/22: us-east5 (Columbus) */
DELETE FROM machinetypes WHERE zone LIKE 'us-east5-%';
DELETE FROM disktypes    WHERE zone LIKE 'us-east5-%';

/* 2022/04/22: us-south1 (Dallas) */
DELETE FROM machinetypes WHERE zone LIKE 'us-south1-%';
DELETE FROM disktypes    WHERE zone LIKE 'us-south1-%';

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