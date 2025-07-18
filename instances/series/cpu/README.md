# CPU Platforms

* Google documentation: <https://cloud.google.com/compute/docs/cpu-platforms>
* Wikipedia
	* Intel: <https://en.wikipedia.org/wiki/Xeon>
	* AMD: <https://en.wikipedia.org/wiki/Epyc>
	* AMPERE: <https://en.wikipedia.org/wiki/Ampere_Computing>
* WikiChip
	* Intel: <https://en.wikichip.org/wiki/intel/microarchitectures>
	* AMD: <https://en.wikichip.org/wiki/amd/microarchitectures>
	* AMPERE: <https://en.wikichip.org/wiki/ampere_computing>

Performance benchmarks are created with [PerfKitBenchmarker](https://github.com/GoogleCloudPlatform/PerfKitBenchmarker) on Compute Engine VM instances.

* Google documentation: <https://cloud.google.com/compute/docs/benchmarks-linux>
* Wikipedia: <https://googlecloudplatform.github.io/PerfKitBenchmarker/>

More help with resource mappings from on-premises hardware to Google Cloud: <https://cloud.google.com/architecture/resource-mappings-from-on-premises-hardware-to-gcp>

## Coremark Benchmark

Copy benchmarks from website <https://cloud.google.com/compute/docs/benchmarks-linux> and paste as unformatted text (<kbd>Crtl</kbd>+<kbd>Shift</kbd>+<kbd>V</kbd>) to spreadsheet (`coremark.ods`) and export as CSV (`coremark.csv`).

Run `coremark.pl` to convert CSV to SQL:
```shell
perl coremark.pl > coremark.sql
```

## Intel

Intel Xeon processor family

### Sandy Bridge

* Code named: Sandy Bridge-EP (E5-46xx)
* Release date: 2012

### Ivy Bridge

* Code named: Ivy Bridge-EP (E5-46xx v2)
* Release date: 2014

### Haswell

* Code name: Haswell-EP (E5-46xx v3)
* Release date: 2015

### Broadwell

* Code name: Broadwell (E3/E5-1xxx/E5-2xxx v4)
* Release date: 2015

### Skylake

* Code name: Skylake-SP
* Release date: 2017

### Cascade Lake

* Code name: Cascade Lake-SP
* Release date: 2019

### Ice Lake

* Code name: Ice Lake-SP
* Release date: 2021

### Sapphire Rapids

* Code name: Sapphire Rapids
* Release date: 2023

### Emerald Rapids

* Code name: Emerald Rapids
* Release date: 2023
* [Wikipedia](https://en.wikipedia.org/wiki/Emerald_Rapids)

### Granite Rapids

* Code name: Granite Rapids
* Release date: 2024
* [Wikipedia](https://en.wikipedia.org/wiki/Granite_Rapids)

## AMD

AMD Zen based Epyc microarchitecture

### Rome

* Generation 2nd
* Release date: 2019

### Milan

* Generation 3rd
* Release date: 2021

### Milan X

* Generation 3rd
* Release date: 2022

### Genoa

* Generation 4rd
* Release date: 2022

## Arm

### Ampere Altra

<https://amperecomputing.com/processors/ampere-altra/>

* SKU: Q64-30
	* Cores: 64
	* Frequency: 3.0 GHz
	* TDP: 180 W
* Release date: 2020