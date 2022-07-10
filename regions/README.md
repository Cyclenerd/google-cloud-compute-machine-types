# Google Cloud Regions

Here you can find the SQL files that add the different information from the Google websites.
The information is in addition to the data of the Google Cloud Compute API.

Feel free to make changes if something is wrong or you want to expand it.

The SQL files are read during the [build](../build/) process.

## Carbon Data

Carbon data across GCP regions from website <https://cloud.google.com/sustainability/region-carbon#data>
and paste as unformatted text (<kbd>Crtl</kbd>+<kbd>Shift</kbd>+<kbd>V</kbd>) to spreadsheet (`carbon.ods`) and export as CSV (`carbon.csv`).

Run `carbon.pl` to convert CSV to SQL:
```shell
perl carbon.pl > carbon.sql
```