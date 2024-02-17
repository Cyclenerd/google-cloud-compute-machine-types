# Google Cloud Compute Comparison

[![Badge: Google Cloud](https://img.shields.io/badge/Google%20Cloud-%234285F4.svg?logo=google-cloud&logoColor=white)](#readme)
[![Badge: CI](https://github.com/Cyclenerd/google-cloud-compute-machine-types/actions/workflows/build.yml/badge.svg)](https://github.com/Cyclenerd/google-cloud-compute-machine-types/actions/workflows/build.yml)
[![Badge: GitHub](https://img.shields.io/github/license/cyclenerd/google-cloud-compute-machine-types)](https://github.com/Cyclenerd/google-cloud-compute-machine-types/blob/master/LICENSE)

This Google Compute Engine machine type comparison [webapp](https://gcloud-compute.com/) helps to find the optimal GCE machine type or instance in the many Google Cloud Platform (GCP) regions. A lot of information has been collected from various Google Cloud websites and different sources.

## Instance Picker

[![Screenshot: gcloud-compute.com - Instance Picker](./img/grid.png)](https://gcloud-compute.com/)

## Comparison

[![Screenshot: gcloud-compute.com - Comparison](./img/compare.png)](https://gcloud-compute.com/comparison/e2-standard-4/vs/t2a-standard-4.html)

## 🖊️ Add, edit or change machine type information

The Google Compute Engine API is used to get all machine types in all regions and zones.
Additional information is read via SQL files during the build process.
These files can be found in the [instances](./instances/) folder.

## 🧑‍💻 Development

If you want to customize the [build](./build/) process or run the webapp on your [Gitpod](https://gitpod.io/#https://github.com/Cyclenerd/google-cloud-compute-machine-types) or local computer,
you need the following requirements.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/Cyclenerd/google-cloud-compute-machine-types)

### Requirements

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
	sqlite3 \
	libapp-options-perl \
	libencode-perl \
	libyaml-libyaml-perl \
	libjson-xs-perl \
	libdbd-csv-perl \
	libdbd-sqlite3-perl \
	libtemplate-perl \
	libplack-perl
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

Build:
```shell
cd build/
bash build.sh
perl site.pl
```

Run:
```shell
plackup --host 127.0.0.1
```

## ❤️ Contributing

Have a patch that will benefit this project?
Awesome! Follow these steps to have it accepted.

1. Please read [how to contribute](CONTRIBUTING.md).
1. Fork this Git repository and make your changes.
1. Create a Pull Request.
1. Incorporate review feedback to your changes.
1. Accepted!


## 📜 License

All files in this repository are under the [Apache License, Version 2.0](LICENSE) unless noted otherwise.

Portions of this webapp are modifications based on work created and shared by [Google](https://developers.google.com/readme/policies)
and used according to terms described in the [Creative Commons 4.0 Attribution License](https://creativecommons.org/licenses/by/4.0/).

Please note:

* No warranty
* No official Google product