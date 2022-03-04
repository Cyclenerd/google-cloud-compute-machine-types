/* Delete machine types that are not available in the region
 * 2022/02/24
 * Skip compute optimized instances (C2) running in Zurich
 * Price is 0: https://cloud.google.com/skus/?currency=USD&filter=AF8B-8E84-6A88
 */
DELETE FROM machinetypes WHERE zone LIKE 'europe-west6-%' AND name LIKE 'c2-%';

/*
 * Remove disconnected data centers
 */
DELETE FROM machinetypes WHERE zone LIKE 'us-central2-%';
DELETE FROM machinetypes WHERE zone LIKE 'us-east2-%';
DELETE FROM machinetypes WHERE zone LIKE 'us-east7-%';
DELETE FROM machinetypes WHERE zone LIKE 'europe-west5-%';