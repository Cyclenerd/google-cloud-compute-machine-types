const options = {
	container: document.getElementById('myChart'),
	autoSize: true,
	title: {
		text: 'Performance by Disk Size',
		enabled: false
	},
	data: [
	{
		size: '10 GB',
		// HDD
		hdd_read: 0,
		hdd_write: 0,
		// SSD
		ssd_read: 4.8,
		ssd_write: 4.8
	},
	{
		size: '32 GB',
		// HDD
		hdd_read: 3,
		hdd_write: 3,
		// SSD
		ssd_read: 15,
		ssd_write: 15
	},
	{
		size: '64 GB',
		// HDD
		hdd_read: 7,
		hdd_write: 7,
		// SSD
		ssd_read: 30,
		ssd_write: 30
	},
	{
		size: '128 GB',
		// HDD
		hdd_read: 15,
		hdd_write: 15,
		// SSD
		ssd_read: 61,
		ssd_write: 61
	},
	{
		size: '256 GB',
		// HDD
		hdd_read: 30,
		hdd_write: 30,
		// SSD
		ssd_read: 122,
		ssd_write: 122
	},
	{
		size: '500 GB',
		// HDD
		hdd_read: 60,
		hdd_write: 60,
		// SSD
		ssd_read: 240,
		ssd_write: 240
	},
	{
		size: '1 TB',
		// HDD
		hdd_read: 120,
		hdd_write: 120,
		// SSD
		ssd_read: 480,
		ssd_write: 480
	},
	{
		size: '2 TB',
		// HDD
		hdd_read: 245,
		hdd_write: 245,
		// SSD
		ssd_read: 983,
		ssd_write: 983
	},
	{
		size: '4 TB',
		// HDD
		hdd_read: 480,
		hdd_write: 400,
		// SSD
		ssd_read: 1200,
		ssd_write: 1200
	},
	{
		size: '5 TB',
		// HDD
		hdd_read: 600,
		hdd_write: 400,
		// SSD
		ssd_read: 1200,
		ssd_write: 1200
	},
	{
		size: '8 TB',
		// HDD
		hdd_read: 983,
		hdd_write: 400,
		// SSD
		ssd_read: 1200,
		ssd_write: 1200
	},
	{
		size: '10 TB',
		// HDD
		hdd_read: 1200,
		hdd_write: 400,
		// SSD
		ssd_read: 1200,
		ssd_write: 1200
	}
	],
	series: [
		{
			xKey: 'size',
			yKey: 'hdd_write',
			yName: 'Standard Write (MBps)',
			stroke: '#20c997',
			marker: {
				shape: 'square',
				fill: '#20c997',
				stroke: '#20c997',
			},
		},
		{
			xKey: 'size',
			yKey: 'hdd_read',
			yName: 'Standard Read (MBps)',
			stroke: '#198754',
			marker: {
				shape: 'square',
				fill: '#198754',
				stroke: '#198754',
			},
		},
		{
			xKey: 'size',
			yKey: 'ssd_write',
			yName: 'SSD Write (MBps)',
			stroke: '#6610f2',
			marker: {
				shape: 'circle',
				fill: '#6610f2',
				stroke: '#6610f2',
			},
		},
		{
			xKey: 'size',
			yKey: 'ssd_read',
			yName: 'SSD Read (MBps)',
			stroke: '#6f42c1',
			marker: {
				shape: 'circle',
				fill: '#6f42c1',
				stroke: '#6f42c1',
			},
		},
	],
	axes: [
		{
			type: 'category',
			position: 'bottom',
			title: {
				text: 'Disk Size',
				enabled: false,
			},
		},
		{
			type: 'number',
			position: 'left',
			title: {
				text: 'Sustained throughput (MBps)',
				enabled: false,
			},
			label: {
				formatter: function (params) { return params.value + ' MBps'; },
			},
		},
	],
	legend: {
		enabled: true,
		position: 'bottom'
	},
};

agCharts.AgChart.create(options);