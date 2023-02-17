# Google Compute Engine

Here you can find the SQL files that add the different information from the Google websites.
The information is in addition to the data of the Google Cloud Compute API.

Feel free to make changes if something is wrong or you want to expand it.

The SQL files are read during the [build](../build/) process.

## Machine Types

* [Series](./series/)
	* [A2](./series/a2.sql)
	* [C2](./series/c2.sql)
	* [C2D](./series/c2d.sql)
	* [C3](./series/c3.sql)
	* [E2](./series/e2.sql)
	* [M1](./series/m1.sql)
	* [M2](./series/m2.sql)
	* [M3](./series/m3.sql)
	* [N1](./series/n1.sql)
	* [N2](./series/n2.sql)
	* [N2D](./series/n2d.sql)
	* [T2D](./series/t2d.sql)
	* [T2A](./series/t2a.sql)
* [CPU Platform](./series/cpu/)
	* [Frequency (GHz)](./series/cpu/frequency.sql)
	* [EEMBC CoreMark Benchmark](./series/cpu/coremark.sql)
* [SAP](./series/sap/)
	* [SAP certified machine types](./series/sap/sap.sql)
	* [SAP HANA certified machine types](./series/sap/hana.sql)

## Costs

The cost per machine type in region and licenses are added with the [gcosts](https://github.com/Cyclenerd/google-cloud-pricing-cost-calculator) program.

## Resources of the Information

<ul>
	<li>
		<a href="https://cloud.google.com/compute/docs/machine-types#machine_type_comparison" rel="nofollow">Machine series comparison</a>
		<ul>
			<li><a href="https://cloud.google.com/compute/docs/accelerator-optimized-machines#a2_vms" rel="nofollow">A2</a> accelerator optimized machines</li>
			<li>
				<a href="https://cloud.google.com/compute/docs/compute-optimized-machines#c2_machine_types" rel="nofollow">C2</a>,
				<a href="https://cloud.google.com/compute/docs/compute-optimized-machines#c2d_machine_typesd" rel="nofollow">C2D</a> and
				<a href="https://cloud.google.com/compute/docs/compute-optimized-machines#c3_machine_types" rel="nofollow">C3</a> compute optimized machine series
			</li>
			<li>
				<a href="https://cloud.google.com/compute/docs/memory-optimized-machines#m1_machine_types" rel="nofollow">M1</a>,
				<a href="https://cloud.google.com/compute/docs/memory-optimized-machines#m2_machine_types" rel="nofollow">M2</a> and
				<a href="https://cloud.google.com/compute/docs/memory-optimized-machines#m3_machine_types" rel="nofollow">M3</a> memory optimized machine series
			</li>
			<li>
				<a href="https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types" rel="nofollow">E2</a>,
				<a href="https://cloud.google.com/compute/docs/general-purpose-machines#n1_machines" rel="nofollow">N1</a>,
				<a href="https://cloud.google.com/compute/docs/general-purpose-machines#n2_machines" rel="nofollow">N2</a>,
				<a href="https://cloud.google.com/compute/docs/general-purpose-machines#n2d_machines" rel="nofollow">N2D</a>,
				<a href="https://cloud.google.com/compute/docs/general-purpose-machines#t2d_machines" rel="nofollow">T2D</a> and
				<a href="https://cloud.google.com/compute/docs/general-purpose-machines#t2a_machines" rel="nofollow">T2A</a> general purpose machine series
			</li>
		</ul>
	</li>
	<li><a href="https://cloud.google.com/compute/docs/regions-zones#available">Available regions and zones</a></li>
	<li><a href="https://cloud.google.com/compute/docs/cpu-platforms" rel="nofollow">CPU Platform</a></li>
	<li><a href="https://cloud.google.com/compute/docs/benchmarks-linux" rel="nofollow">Benchmarks for Linux VM instances</a></li>
	<li><a href="https://cloud.google.com/solutions/sap/docs/certifications-sap-apps#sap-certified-vms" rel="nofollow">Certified SAP applications on Google Cloud</a></li>
	<li><a href="https://cloud.google.com/solutions/sap/docs/certifications-sap-hana#hana-cert-table-vms" rel="nofollow">Certified machine types for SAP HANA</a></li>
</ul>

