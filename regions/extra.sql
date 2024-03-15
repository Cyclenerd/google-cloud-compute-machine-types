/* Extra Data for Regions */

UPDATE instances SET regionLocationLong = "Doha, Qatar",          regionLat = "25.2409741", regionLng = "51.5126395" WHERE region LIKE "me-central1";
UPDATE instances SET regionLocationLong = "Dammam, Saudi Arabia", regionLat = "26.3622236", regionLng = "49.6807149" WHERE region LIKE "me-central2";
UPDATE instances SET regionLocationLong = "Tel Aviv, Israel",     regionLat = "32.0858103", regionLng = "34.7697987" WHERE region LIKE "me-west1";

/* Source: On-site inspection ;) */
UPDATE instances SET regionLocationLong = "Berlin, Germany", regionLat = "52.2630", regionLng = "13.5727" WHERE region LIKE "europe-west10";

/* https://cloud.google.com/blog/products/infrastructure/heita-south-africa-new-cloud-region */
UPDATE instances SET regionLocationLong = "Johannesburg, South Africa", regionLat = "-26.1714376", regionLng = "27.8841339" WHERE region LIKE "africa-south1";

/* Source: Google Maps search "Google Data Center" and 2021-carbon-free-energy-data-centers.pdf */
UPDATE instances SET regionLocationLong = "St. Ghislain, Belgium",     regionLat = "50.4690", regionLng = "3.8658"    WHERE region LIKE "europe-west1";
UPDATE instances SET regionLocationLong = "Eemshaven, Netherlands",    regionLat = "53.4259", regionLng = "6.8642"    WHERE region LIKE "europe-west4";
UPDATE instances SET regionLocationLong = "Hamina, Finland",           regionLat = "60.5376", regionLng = "27.1163"   WHERE region LIKE "europe-north1";
UPDATE instances SET regionLocationLong = "The Dalles, Oregon, USA",   regionLat = "45.6407", regionLng = "-121.1991" WHERE region LIKE "us-west1";
UPDATE instances SET regionLocationLong = "Las Vegas, Nevada, USA",    regionLat = "36.0563", regionLng = "-115.0090" WHERE region LIKE "us-west4";
UPDATE instances SET regionLocationLong = "Council Bluffs, Iowa, USA", regionLat = "41.2210", regionLng = "-95.8639"  WHERE region LIKE "us-central1";

/*
Source: https://cloud.google.com/blog/products/infrastructure/new-google-cloud-region-in-turin-italy-now-open
*/
UPDATE instances SET regionLocationLong = "Turin, Italy", regionLat = "45.146729", regionLng = "7.742147" WHERE region LIKE "europe-west12";

/*
Source: https://cloud.google.com/blog/products/infrastructure/new-google-cloud-region-in-madrid-spain-now-open
[...] Built in partnership with Telefónica [...]
*/
UPDATE instances SET regionLat = "40.5195333", regionLng = "3.3409366" WHERE region LIKE "europe-southwest1";

/* https://cloud.google.com/compute/docs/regions-zones/ */
UPDATE instances SET regionLocationLong = "Changhua County, Taiwan, Republic of China" WHERE region LIKE "asia-east1";
UPDATE instances SET regionLocationLong = "Jurong West, Singapore"                     WHERE region LIKE "asia-southeast1";
UPDATE instances SET regionLocationLong = "Osasco, São Paulo, Brazil"                  WHERE region LIKE "southamerica-east1";
UPDATE instances SET regionLocationLong = "Moncks Corner, South Carolina, USA"         WHERE region LIKE "us-east1";
UPDATE instances SET regionLocationLong = "Ashburn, Northern Virginia, USA"            WHERE region LIKE "us-east4";

/*
 * europe-west9 (Paris, France) is Global Switch data center in Clichy
 * Source: https://lafibre.info/datacenter/incendie-maitrise-globalswitch-clichy/
 */
UPDATE instances SET regionLat = "48.8996", regionLng = "2.2961" WHERE region LIKE "europe-west9";
