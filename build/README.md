# Build

The build process is handled by [GitHub Actions](https://github.com/Cyclenerd/google-cloud-compute-machine-types/actions/workflows/build.yml).

[![Build](https://github.com/Cyclenerd/google-cloud-compute-machine-types/actions/workflows/build.yml/badge.svg)](https://github.com/Cyclenerd/google-cloud-compute-machine-types/actions/workflows/build.yml)

## Database and CSV

Run:
```shell
bash build.sh
```

1. Create SQLite3 database `gce.db` for GCE machine type informations
1. Export all Google Compute Engine machine types ans zones via the Google Compute Engine API to CSV file `machinetypes.csv` and `zones.csv`
1. Copy machine types ans zones from CSV file to SQLite database `gce.db` table `machinetypes` and `zones`
1. Clean up (Remove disconnected data centers...)
1. Copy machine types per region to database table `instances`
1. Add costs for machine types in region from [pricing](https://github.com/Cyclenerd/google-cloud-pricing-cost-calculator)
1. Add [additional machine type informations](../instances/series/)
1. Add available CPU platforms per instance in region
1. Add even more
	* Frequency (GHz)
	* EEMBC CoreMark Benchmark
	* SAP and HANA certified machine types
1. Export CSV and SQL file
1. Test

## Website and JSON

Run:
```shell
perl site.pl
```

This Perl script creates the static webapp (Templates are located in the [src](./src/) folder). The webapp is saved in the directory `../site`.