# Build

This project uses GitHub Actions for automated builds and deployments.
Ready to tweak and test this webapp locally?
Follow these instructions:

## Requirements

* [Google Cloud CLI](https://cloud.google.com/sdk/docs/install) (`gcloud`)
* SQLite3 (`sqlite3`)
* Perl 5 (`perl`)
* Perl modules:
	* [App::Options](https://metacpan.org/pod/App::Options)
	* [Encode](https://metacpan.org/pod/Encode)
	* [YAML::XS](https://metacpan.org/pod/YAML::XS) (and `libyaml`)
	* [JSON::XS](https://metacpan.org/pod/JSON::XS)
	* [DBD::CSV](https://metacpan.org/pod/DBD::CSV)
	* [DBD::SQLite](https://metacpan.org/pod/DBD::SQLite)
	* [Template::Toolkit](https://metacpan.org/pod/Template::Toolkit)
	* [plackup](https://metacpan.org/dist/Plack/view/script/plackup)

<details>
<summary><b>Debian/Ubuntu</b></summary>

Packages:

```shell
sudo apt update
sudo apt install \
	libapp-options-perl \
	libdbd-csv-perl \
	libdbd-sqlite3-perl \
	libencode-perl \
	libjson-xs-perl \
	libplack-perl \
	libtemplate-perl \
	libyaml-libyaml-perl \
	sqlite3
```

[Google Cloud CLI](https://cloud.google.com/sdk/docs/install#deb):

```shell
sudo apt-get install apt-transport-https ca-certificates gnupg
# Add the gcloud CLI distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import the Google Cloud public key.
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg
# Update and install the gcloud CLI
sudo apt-get update
sudo apt-get install google-cloud-cli
```
</details>

<details>
<summary><b>macOS</b></summary>

Homebrew packages:

```shell
brew install perl
brew install cpanminus pkg-config
brew install sqlite3
brew install --cask google-cloud-sdk
```

Perl modules:

```shell
cpanm --installdeps .
```
</details>

## Database

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
7. Add [additional machine type informations](../instances/series/)
1. Add CPU platforms and IP addresses
	1. Add available CPU platforms per instance in region
	1. Add number of public IP addresses for each GCP region
1. Add even more
	* Frequency (GHz)
	* EEMBC CoreMark Benchmark
	* SAP and HANA certified machine types
1. Export CSV and SQL file
1. Test

## Websites

Create:

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

Run:

```bash
plackup --host "127.0.0.1" --port "8080"
```