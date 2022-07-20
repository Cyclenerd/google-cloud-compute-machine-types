/* Extra Data for Regions */

/* Source: Google Maps search "Google Data Center" and 2021-carbon-free-energy-data-centers.pdf */
UPDATE instances SET regionLocationLong = "St. Ghislain, Belgium",     regionLat = "50.4690", regionLng = "3.8658"    WHERE region LIKE "europe-west1";
UPDATE instances SET regionLocationLong = "Eemshaven, Netherlands",    regionLat = "53.4259", regionLng = "6.8642"    WHERE region LIKE "europe-west4";
UPDATE instances SET regionLocationLong = "Hamina, Finland",           regionLat = "60.5376", regionLng = "27.1163"   WHERE region LIKE "europe-north1";
UPDATE instances SET regionLocationLong = "The Dalles, Oregon, USA",   regionLat = "45.6407", regionLng = "-121.1991" WHERE region LIKE "us-west1";
UPDATE instances SET regionLocationLong = "Las Vegas, Nevada, USA",    regionLat = "36.0563", regionLng = "-115.0090" WHERE region LIKE "us-west4";
UPDATE instances SET regionLocationLong = "Council Bluffs, Iowa, USA", regionLat = "41.2210", regionLng = "-95.8639"  WHERE region LIKE "us-central1";

/* https://cloud.google.com/compute/docs/regions-zones/ */
UPDATE instances SET regionLocationLong = "Changhua County, Taiwan, Republic of China" WHERE region LIKE "asia-east1";
UPDATE instances SET regionLocationLong = "Jurong West, Singapore"                     WHERE region LIKE "asia-southeast1";
UPDATE instances SET regionLocationLong = "Osasco, São Paulo, Brazil"                  WHERE region LIKE "southamerica-east1";
UPDATE instances SET regionLocationLong = "Moncks Corner, South Carolina, USA"         WHERE region LIKE "us-east1";
UPDATE instances SET regionLocationLong = "Ashburn, Northern Virginia, USA"            WHERE region LIKE "us-east4";