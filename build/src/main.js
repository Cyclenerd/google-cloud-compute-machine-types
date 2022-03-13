/*
 * FILTERS
 */

// URL params for initial filter
const queryString = window.location.search;
const urlParams   = new URLSearchParams(queryString);
const urlRegion   = urlParams.get('region')   || '';
const urlName     = urlParams.get('name')     || '';
const urlSAP      = urlParams.get('sap')      || '';
const urlHANA     = urlParams.get('hana')     || '';
const urlSeries   = urlParams.get('series')   || '';
const urlPlatform = urlParams.get('platform') || '';

const filterParamsNumber = {
	filterOptions: ['equals', 'greaterThan', 'greaterThanOrEqual', 'lessThan', 'lessThanOrEqual'],
	defaultOption: 'greaterThanOrEqual',
	debounceMs: 100,
};
const filterParamsText = {
	filterOptions: ['equals', 'notEqual', 'contains', 'notContains', 'startsWith', 'endsWith'],
	defaultOption: 'contains',
	debounceMs: 100,
};
const filterParamsBoolean = {
	filterOptions: ['equals'],
	defaultOption: 'equals',
	suppressAndOrCondition: true,
	debounceMs: 0,
};

/*
 * FORMATTERS
 */

function booleanFormatter(params) {
	return (params.value >= 1) ? '✔️' : '❌';
}

/*
 * KEYBOARD
 */

document.addEventListener('keydown', function(event) {
	if (event.altKey && event.key === 'c') {
		navigator.clipboard.writeText(gridOptions.api.getDataAsCsv({
			skipColumnGroupHeaders: true,
			skipColumnHeaders: false,
			allColumns: false,
			onlySelected: true,
		}));
	}
	if (event.altKey && event.key === 'a') {
		navigator.clipboard.writeText(gridOptions.api.getDataAsCsv({
			skipColumnGroupHeaders: true,
			skipColumnHeaders: false,
			allColumns: true,
			onlySelected: true,
		}));
	}
	if (event.ctrlKey && event.key === 'c') {
		navigator.clipboard.writeText(gridOptions.api.getDataAsCsv({
			skipColumnGroupHeaders: true,
			skipColumnHeaders: true,
			allColumns: false,
			onlySelected: true,
		}));
	}
	if (event.ctrlKey && event.key === 'a') {
		navigator.clipboard.writeText(gridOptions.api.getDataAsCsv({
			skipColumnGroupHeaders: true,
			skipColumnHeaders: true,
			allColumns: true,
			onlySelected: true,
		}));
	}
	if (event.ctrlKey && event.key === '/') {
		document.querySelector('[aria-label="vCPU Filter Input"]').focus();
	}
	if (event.key === '?') {
		var helpModal = new bootstrap.Modal(document.getElementById('helpModal'), {
			//keyboard: false
		})
		helpModal.show();
	}
});

/*
 * GRID
 */

const gridOptions = {
	columnDefs: [
		{
			headerName: 'Machine Types',
			children: [
				{
					headerName: 'Name',
					field: "name",
					cellRenderer: params => {
						return '<a href="./'+ params.data.region +'/'+ params.value +'.html">'+ params.value + '</a>';
					},
					tooltipValueGetter: params => {
						return 'Machine type '+  params.value +' ('+ params.data.vCpus + ' vCPUs, '+ params.data.memoryGiB + ' GB, '+ params.data.bandwidth + ' Gbps) in region '+ params.data.region;
					},
					pinned: 'left',
					//rowDrag: true,
					checkboxSelection: true,
					width: 180,
				},
			]
		},
		// groupId: 1
		{
			headerName: 'Region',
			children: [
				{
					headerName: 'Name',
					field: "region",
					columnGroupShow: 'close',
					tooltipField: 'region',
					width: 180,
				},
				{
					headerName: 'Location',
					field: "regionLocation",
					columnGroupShow: 'open',
					tooltipField: 'regionLocation',
					width: 120
				},
			]
		},
		// groupId: 2
		{
			headerName: 'Zones',
			children: [
				{
					headerName: '#Zones',
					field: "zoneCount",
					columnGroupShow: 'close',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					cellClass: params => {
						if (params.value <= 1) { return 'warning' }
					},
					tooltipField: 'zoneCount',
					width: 90,
					headerTooltip: 'Available in zones',
				},
				{
					headerName: 'Names',
					field: "zones",
					columnGroupShow: 'open',
					tooltipField: 'zones',
					width: 180,
					headerTooltip: 'Available in zone names',
				},
			]
		},
		// groupId: 2
		// groupId is used in setColumnGroupState for inital filter
		{
			headerName: 'Prozessor',
			children: [
				{ 
					headerName: 'vCPU',
					field: "vCpus",
					columnGroupShow: 'close',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					cellClass: params => {
						if (params.data.sharedCpu >= 1) { return 'sharedCpu' }
					},
					headerTooltip: 'A vCPU represents a single logical CPU thread',
					width: 90,
				},
				{ 
					headerName: 'Base Frequency',
					field: "cpuBaseClock",
					columnGroupShow: 'close',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					headerTooltip: 'CPU base clock frequency',
					width: 120,
					cellClass: 'frequency',
				},
				{ 
					headerName: 'Turbo Frequency',
					field: "cpuTurboClock",
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					headerTooltip: 'CPU all-core turbo frequency / effective frequency',
					width: 120,
					cellClass: 'frequency',
				},
				{ 
					headerName: 'Max. Turbo Frequency',
					field: "cpuSingleMaxTurboClock",
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					headerTooltip: 'CPU single-core max turbo frequency / max boost frequency',
					width: 120,
					cellClass: 'frequency',
				},
				{
					headerName: 'Shared',
					field: 'sharedCpu',
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					headerTooltip: 'Fractional vCPU (1, 0) [Each vCPU can burst up to 100% of CPU time, for short periods, before returning to the time limitations]',
					width: 90
				},
				{
					headerName: 'Intel',
					field: 'intel',
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					headerTooltip: 'Intel CPU processors (1, 0)',
					width: 90
				},
				{
					headerName: 'AMD',
					field: 'amd',
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					headerTooltip: 'AMD CPU processors (1, 0)',
					width: 90
				},
				{
					headerName: '#Available',
					field: 'availableCpuPlatformCount',
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					headerTooltip: 'Available CPU platforms for machine type in regions',
					width: 90
				},
				{
					headerName: 'Available CPU Platform',
					field: 'availableCpuPlatform',
					columnGroupShow: 'open',
					headerTooltip: 'Available CPU flatform for machine type in region',
					tooltipField: 'availableCpuPlatform'
				},
				{
					headerName: '#Div',
					field: 'notAvailableCpuPlatformCount',
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					cellClass: params => {
						if (params.value >= 1) { return 'warning' }
					},
					headerTooltip: 'Not available CPU platforms for machine type in regions',
					width: 90
				},
				{
					headerName: '#Platform',
					field: 'cpuPlatformCount',
					columnGroupShow: 'open',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					headerTooltip: 'Available CPU platforms for machine type in regions',
					width: 90
				},
				{
					headerName: 'CPU Platform',
					field: 'cpuPlatform',
					columnGroupShow: 'open',
					headerTooltip: 'Available CPU platform for machine type',
					tooltipField: 'cpuPlatform'
				},
			]
		},
		{
			headerName: 'Benchmark',
			children: [
				{ headerName: 'CoreMark', field: "coremarkScore",     columnGroupShow: 'close', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, headerTooltip: 'EEMBC CoreMark Benchmark (please see www.eembc.org/coremark)', width: 120 },
				{ headerName: 'StdDev%',  field: "standardDeviation", columnGroupShow: 'open',  filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, headerTooltip: 'EEMBC CoreMark Standard Deviation (%)', width: 120 },
				{ headerName: '#Samples', field: "sampleCount",       columnGroupShow: 'open',  filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, headerTooltip: 'EEMBC CoreMark Sample Count', width: 120 },
			]
		},
		{ headerName: 'Memory', field: "memoryGiB", cellClass: 'memory', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, headerTooltip: 'Random-access memory (GiB)', width: 120, },
		{
			headerName: 'Network',
			children: [
				{ headerName: 'Bandwidth', field: "bandwidth", cellClass: 'bandwidth', columnGroupShow: 'close', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, headerTooltip: 'Maximum egress bandwidth (Gbps) cannot exceed the number given', width: 120, },
				{ headerName: 'Tier 1',    field: "tier1",     cellClass: 'bandwidth', columnGroupShow: 'open',  filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, headerTooltip: 'High-bandwidth (Gbps) networking for larger machine types', width: 120 },
			]
		},
		{
			headerName: 'Storage',
			children: [
				{
					headerName: 'Disk Size',
					field: "diskSizeTiB",
					columnGroupShow: 'close',
					cellClass: 'diskSize',
					width: 100,
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					headerTooltip: 'Max. total persistent disk size (TB) [Disk usage is charged separately from machine type pricing!]'
				},
				{
					headerName: '#Disks',
					field: "disks",
					columnGroupShow: 'open',
					width: 90,
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					headerTooltip: 'Max. number of persistent disks (PDs) [Disk usage is charged separately from machine type pricing!]'
				},
				{
					headerName: 'Local SSD',
					field: "localSsd",
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90,
					headerTooltip: 'VM supports local solid-state drive (SSD) block storage'
				},
			]
		},
		{
			headerName: 'Costs',
			children: [
				{
					headerName: 'Hour',
					field: "hour",
					width: 120,
					cellClass: 'currency',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					columnGroupShow: 'close',
					// Default sorting on the hour column
					sort: 'asc'
				},
				{ headerName: 'Month',                  field: 'month',             width: 120, cellClass: 'currency', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, columnGroupShow: 'close' },
				{ headerName: '1Y CUD',                 field: "month1yCud",        width: 120, cellClass: 'currency', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, columnGroupShow: 'open' },
				{ headerName: '3Y CUD',                 field: "month3yCud",        width: 120, cellClass: 'currency', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, columnGroupShow: 'open' },
				{ headerName: 'SLES',                   field: 'monthSles',         width: 120, cellClass: 'currency', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, columnGroupShow: 'open', headerTooltip: 'SUSE Linux Enterprise Server' },
				{ headerName: 'RHEL',                   field: 'monthRhel',         width: 120, cellClass: 'currency', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, columnGroupShow: 'open', headerTooltip: 'Red Hat Enterprise Linux' },
				{ headerName: 'Windows',                field: 'monthWindows',      width: 120, cellClass: 'currency', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, columnGroupShow: 'open', headerTooltip: 'Microsoft Windows Server' },
				{ headerName: 'SLES for SAP',           field: 'monthSlesSap',      width: 120, cellClass: 'currency', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, columnGroupShow: 'open', headerTooltip: 'SUSE Linux Enterprise Server for SAP' },
				{ headerName: 'SLES for SAP w. 1Y CUD', field: 'monthSlesSap1yCud', width: 120, cellClass: 'currency', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, columnGroupShow: 'open', headerTooltip: 'SUSE Linux Enterprise Server for SAP with 1 Year CUD' },
				{ headerName: 'SLES for SAP w. 3Y CUD', field: 'monthSlesSap3yCud', width: 120, cellClass: 'currency', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, columnGroupShow: 'open', headerTooltip: 'SUSE Linux Enterprise Server for SAP with 1 Year CUD' },
				{ headerName: 'RHEL for SAP',           field: 'monthRhelSap',      width: 120, cellClass: 'currency', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, columnGroupShow: 'open', headerTooltip: 'Red Hat Enterprise Linux for SAP' },
				{
					headerName: 'SUD',
					field: "sud",
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90,
					headerTooltip: 'Instance with SUD (sustained use discounts are automatic discounts for running specific Compute Engine resources)'
				},
			]
		},
		{
			// groupId: 8
			// groupId is used in setColumnGroupState for inital filter
			headerName: 'SAP',
			children: [
				{
					headerName: 'SAPS',
					field: 'saps',
					columnGroupShow: 'close',
					filter: 'agNumberColumnFilter',
					filterParams: filterParamsNumber,
					headerTooltip: 'SAP Standard Benchmark (please see SAP Note 1612283 and 2456432)',
					width: 90
				},
				{
					headerName: 'SAP',
					field: "sap",
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90,
					headerTooltip: 'Certified for SAP applications on Google Cloud'
				},
				{
					headerName: 'HANA',
					field: "hana",
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90,
					headerTooltip: 'Certified for SAP HANA on Google Cloud'
				},
			]
		},
		{
			// groupId: 9
			// groupId is used in setColumnGroupState for inital filter
			headerName: 'More...',
			children: [
				{ headerName: 'Family',         field: "family",          columnGroupShow: 'close', width: 180, tooltipField: 'family', headerTooltip: 'A curated set of processor and hardware configurations optimized for specific workloads' },
				{ headerName: 'Series',         field: "series",          columnGroupShow: 'open',  width: 110, headerTooltip: 'Machine families are further classified by series and generation'},
				{ headerName: 'GPUs',           field: "acceleratorCount",columnGroupShow: 'open', filter: 'agNumberColumnFilter', filterParams: filterParamsNumber, width: 100 },
				{ headerName: 'GPU Type',       field: "acceleratorType", columnGroupShow: 'open' },
				{
					headerName: 'Spot',
					field: "spot",
					columnGroupShow: 'open',
					filterParams: filterParamsBoolean,
					valueFormatter: booleanFormatter,
					width: 90,
					headerTooltip: 'Instance supports spot provisioning mode (Spot VM)'
				},

			]
		}
	],
	// Defaults
	defaultColDef: {
		resizable: true,
		sortable: true,
		minWidth: 90,
		maxWidth: 400,
		//width: 110,
		filter: 'agTextColumnFilter',
		filterParams: filterParamsText,
		floatingFilter: true,
		//editable: true,
	},
	groupHideOpenParents: true,
	tooltipShowDelay: 0,
	debounceVerticalScrollbar: true,
	ensureDomOrder: true,
	suppressColumnVirtualisation: true,
	rowBuffer: 60,
	rowSelection: 'multiple',
	rowMultiSelectWithClick: true,
	//rowDragManaged: true,
	//rowDragMultiRow: true,
	pagination: true,
	paginationPageSize: 45,
	//domLayout: 'autoHeight',
};

// lookup the container we want the Grid to use
const eGridDiv = document.querySelector('#myGrid');

// create the grid passing in the div to use together with the columns & data we want to use
new agGrid.Grid(eGridDiv, gridOptions);

// fetch the row data to use and one ready provide it to the Grid via the Grid API
fetch('instance_in_region.json?[% timestamp %]')
	.then(response => response.json())
	.then(data => {
		gridOptions.api.setRowData(data);
	}
);

// page has finished loading
document.addEventListener('DOMContentLoaded', function () {
	console.log('DOMContentLoaded');
	// Welcome toast
	var welcomeToast = document.getElementById('welcomeToast');
	var toast = new bootstrap.Toast(welcomeToast);
	toast.show();
});

// fist time data is rendered into the grid
gridOptions.api.addEventListener('firstDataRendered', function () {
	console.log('firstDataRendered');
	// Initial filter with URL params
	let filterName     = urlName.replace(/[^\w\d\-]/g,"");
	let filterRegion   = urlRegion.replace(/[^\w\d\-]/g,"");
	let filterPlatform = urlPlatform.replace(/[^\w\d]/g,"");
	let filterSAP      = (urlSAP >= 1) ? '1' : '';
	let filterHANA     = (urlHANA >= 1) ? '1' : '';
	let filterSeries   = urlSeries.replace(/[^\w\d]/g,"");
	// Set filter
	var hardcodedFilter = {
		name: {
			type: 'equals',
			filter: filterName,
		},
		region: {
			type: 'equals',
			filter: filterRegion,
		},
		availableCpuPlatform: {
			type: 'contains',
			filter: filterPlatform,
		},
		sap: {
			type: 'equals',
			filter: filterSAP,
		},
		hana: {
			type: 'equals',
			filter: filterHANA,
		},
		series: {
			type: 'equals',
			filter: filterSeries,
		},
	};
	// Open groups
	var hardcodedGroupState = [];
	if (filterSAP || filterHANA) {
		hardcodedGroupState.push({ groupId: '8', open: true });
	}
	if (filterPlatform) {
		hardcodedGroupState.push({ groupId: '3', open: true });
	}
	if (filterSeries) {
		hardcodedGroupState.push({ groupId: '9', open: true });
	}
	// wait 500ms, because maybe the DOM isn't completely ready yet
	setTimeout(function(){
		gridOptions.columnApi.setColumnGroupState(hardcodedGroupState);
		gridOptions.api.setFilterModel(hardcodedFilter);
	}, 500);
});