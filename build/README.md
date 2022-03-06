# Build

## Database and CSV

Run:
```shell
bash build.sh
```

1. Create SQLite3 database `gce.db` for GCE machine type informations
1. Export all Google Compute Engine machine types via the Google Compute Engine API to CSV file `machinetypes.csv`
1. Copy machine types from CSV file `machinetypes.csv` to SQLite database `gce.db` table `machinetypes`
1. Clean up (Remove disconnected data centers...)
1. Copy machine types per region to database table `instances`
1. Add costs for machine types in region from [pricing](https://github.com/Cyclenerd/google-cloud-pricing-cost-calculator)
1. Add additional machine type informations
1. Export CSV and SQL file
1. Test

## Website and JSON

Run:
```shell
perl site.pl
```

This Perl script creates the static webapp (Templates are located in the [src](./src/) folder). The webapp is saved in the directory [../site](../site/).