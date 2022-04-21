/* 
 * Delete not yet official 100% finished regions
 */
/* 2022/03/28: Paris */
DELETE FROM machinetypes WHERE zone LIKE 'europe-west9-%';
DELETE FROM disktypes    WHERE zone LIKE 'europe-west9-%';

/* Delete machine types that are not available in the region
 * 2022/02/24
 * Skip compute optimized instances (C2) running in Zurich
 * Price is 0: https://cloud.google.com/skus/?currency=USD&filter=AF8B-8E84-6A88
 */
DELETE FROM machinetypes WHERE zone LIKE 'europe-west6-%' AND name LIKE 'c2-%';

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