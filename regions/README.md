# Google Cloud Regions

Here you can find the SQL files that add the different information from the Google websites.
The information is in addition to the data of the Google Cloud Compute API.

Feel free to make changes if something is wrong or you want to expand it.

The SQL files are read during the [build](../build/) process.

## Carbon Data

Mirror [carbon data across GCP regions](https://cloud.google.com/sustainability/region-carbon#data) from GitHub repo <https://github.com/GoogleCloudPlatform/region-carbon-info>:

```shell
curl -o "carbon.csv" \
  "https://raw.githubusercontent.com/GoogleCloudPlatform/region-carbon-info/main/data/yearly/2021.csv"
```

Run `carbon.pl` to convert CSV to SQL:
```shell
perl carbon.pl > carbon.sql
```