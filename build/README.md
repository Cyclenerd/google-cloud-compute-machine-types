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

The JavaScript grid library [AG Grid Community](https://www.ag-grid.com/) is used.

## Publish

The static webapp is stored in a Google Cloud Storage bucket.

» [Host a static website](https://cloud.google.com/storage/docs/hosting-static-website)

Create:
```shell
gsutil mb -p PROJECT_ID -c Standard -l us-central1 -b on gs://gcloud-compute.com
gsutil iam ch allUsers:objectViewer gs://gcloud-compute.com
gsutil web set -m index.html -e 404.html gs://gcloud-compute.com
```

Copy:
```shell
gsutil -m rsync -d -r site gs://gcloud-compute.com
```

Cloudflare is used as CDN. The following must be added to the DNS management for gcloud-compute.com:

```text
gcloud-compute.com CNAME c.storage.googleapis.com
```