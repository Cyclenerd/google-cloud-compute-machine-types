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
1. Copy machine types per region to database table `instances` and disk types per region to table `disks`
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

No regions and comparison:
```shell
perl site.pl \
  --comparison=0 \
  --region=0
```

Only `g1-small` and `europe-west4`:
```shell
perl site.pl \
  --comparison=1 \
  --limit_comparison=g1-small \
  --region=1 \
  --limit_region=europe-west4
```

This Perl script creates static websites (Templates are located in the [src](./src/) folder).
The websites are stored in the directory `../site/`.

The JavaScript grid library [AG Grid Community](https://www.ag-grid.com/) is used.

## Open Graph

Run:
```shell
perl opengraph.pl
```

This Perl script creates [Open Graph](https://ogp.me/) images for all GCE machines in all regions.
The images are stored in the directory `../opengraph/`.

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

### Open Graph Images

Open Graph images are stored in a separate Google Cloud Storage bucket.

Copy:
```shell
gsutil -m rsync -r opengraph gs://opengraph.gcloud-compute.com
```

Cloudflare is used as CDN. The following must be added to the DNS management for gcloud-compute.com:

```text
opengraph.gcloud-compute.com CNAME c.storage.googleapis.com
```

Test:

* [Twitter Card Validator](https://cards-dev.twitter.com/validator)
* [LinkedIn Post Inspector](https://www.linkedin.com/post-inspector/inspect/)