# Build

## Database and CSV

Run:
```shell
bash build.sh
```

1. Create SQLite3 database for GCE machine type informations
1. Export all Google Compute Engine machine types via the Google Compute Engine API and create a CSV file
1. Copy machine types from CSV export to SQLite database
1. Clean up (Remove disconnected data centers...)
1. Add costs for instance in region from [pricing](https://github.com/Cyclenerd/google-cloud-pricing-cost-calculator)
1. Add additional machine type informations
1. Export CSV

## Website and JSON

Run:
```shell
perl site.pl
```

* Create static website (Templates are located in the [src](./src/) folder)