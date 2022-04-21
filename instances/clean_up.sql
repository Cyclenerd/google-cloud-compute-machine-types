/* 
 * Delete not yet official 100% finished regions
 */
/* 2022/03/28: Paris */
DELETE FROM machinetypes WHERE zone LIKE 'europe-west9-%';
DELETE FROM disktypes    WHERE zone LIKE 'europe-west9-%';

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