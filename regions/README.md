# Google Cloud Regions

Here you can find the SQL files that add the different information from the Google websites.
The information is in addition to the data of the Google Cloud Compute API.

Feel free to make changes if something is wrong or you want to expand it.

The SQL files are read during the [build](../build/) process.

## Carbon Data (`carbon.sql`)

Mirror [carbon data across GCP regions](https://cloud.google.com/sustainability/region-carbon#data) from GitHub repo <https://github.com/GoogleCloudPlatform/region-carbon-info>:

```shell
curl -o "carbon.csv" \
  "https://raw.githubusercontent.com/GoogleCloudPlatform/region-carbon-info/main/data/yearly/2021.csv"
```

Run `carbon.pl` to convert CSV to SQL:
```shell
perl carbon.pl > carbon.sql
```

## Region Locations (`regions.sql`)

Add long region location name, latitude and longitude.

Mirror [regions.json](https://github.com/GoogleCloudPlatform/region-picker/blob/main/data/regions.json) from GitHub repo <https://github.com/GoogleCloudPlatform/region-picker>:

```shell
curl -O "https://raw.githubusercontent.com/GoogleCloudPlatform/region-picker/main/data/regions.json"
```

Run `regions.pl` to convert CSV to SQL:
```shell
perl regions.pl > regions.sql
```

## Country Codes (`country.sql`)

Source: <https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2>

Add ISO 3166-1 alpha-2 country code to `country.sql`.