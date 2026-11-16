#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use File::Temp qw(tempdir);
use FindBin;
use DBI;
use YAML::XS qw(DumpFile);
use JSON::XS qw(decode_json);
use Template;

# Offline ingestion, enrichment and real site rendering. All prices are synthetic.
my $build = $FindBin::Bin;
my $tmp = tempdir(CLEANUP => 1);
chdir $tmp or die $!;
sub slurp {
	my ($file) = @_;
	open my $fh, '<', $file or die "$file: $!";
	local $/;
	return <$fh>;
}
my $db = DBI->connect('dbi:SQLite:dbname=gce.db', '', '', {
	RaiseError => 1, sqlite_allow_multiple_statements => 1
});
$db->do(slurp("$build/01_create_database.sql"));
my @machines = qw(z4m-highmem-16 z4m-highmem-32 z4m-highmem-48 z4m-highmem-192 z4m-highmem-192-metal n2-standard-8);
my $pricing = { region => { 'us-central1' => { location => 'Iowa' } } };
for my $machine (@machines) {
	$db->do("INSERT INTO instances (name, region) VALUES (?, 'us-central1')", undef, $machine);
	my $cost = { hour => 2, month => 1460, month_1y => 1000, month_3y => 800 };
	unless ($machine =~ /-metal$/) { $cost->{hour_spot} = 0.5; $cost->{month_spot} = 365; }
	$pricing->{compute}->{instance}->{$machine}->{cost}->{'us-central1'} = $cost;
	for my $os (qw(sles sles-sap rhel rhel-sap windows)) {
		next if $machine =~ /^z4m-/ && $os eq 'windows';
		$pricing->{compute}->{license}->{$machine}->{cost}->{$os}->{month} = 10;
	}
}
DumpFile('pricing.yml', $pricing);
sub run_script {
	my ($script, @args) = @_;
	open my $stdout, '>&', \*STDOUT or die $!;
	open my $stderr, '>&', \*STDERR or die $!;
	open STDOUT, '>', 'run.log' or die $!;
	open STDERR, '>&', \*STDOUT or die $!;
	my $status = system($^X, "$build/$script", @args);
	open STDOUT, '>&', $stdout or die $!;
	open STDERR, '>&', $stderr or die $!;
	is($status, 0, "$script succeeds offline") or diag(slurp('run.log'));
}
run_script('06_add_costs.pl');
for (1..2) {
	$db->do(slurp("$build/../instances/series/z4m.sql"));
	my $metal = $db->selectrow_hashref("SELECT * FROM instances WHERE name = 'z4m-highmem-192-metal'");
	ok(!defined $metal->{hourSpot} && !defined $metal->{monthSpot}, 'bare metal does not inherit ordinary price as Spot');
	is($db->selectrow_array("SELECT COUNT(*) FROM instances WHERE name LIKE 'z4m-%' AND monthWindows IS NULL"), 5, 'unsupported Windows remains NULL for all Z4M types');
}
is($db->selectrow_array("SELECT hourSpot FROM instances WHERE name = 'z4m-highmem-16'"), 0.5, 'VM Spot price preserved');
is($db->selectrow_array("SELECT monthWindows FROM instances WHERE name = 'n2-standard-8'"), 10, 'non-Z4M Windows price preserved');

# Render the real site using the enriched database and temporary export placeholders.
symlink "$build/src", 'src' or die $!;
mkdir 'site' or die $!;
for my $file ('machine-types-regions.csv', 'machine-types-regions.sql.gz') {
	open my $fh, '>', $file or die $!;
	print $fh "offline test\n";
}
run_script('site.pl', '-site_folder=site', '-comparison=1', '-region=1');
my $instances = slurp('site/instances.html');
like($instances, qr/\.currency:empty::before\s*\{ content: "N\/A";/, 'empty currency cells display N/A, not a dollar amount');
my ($metal_row) = $instances =~ m{(<tr>\s*<td><a href="/z4m-highmem-192-metal\.html".*?</tr>)}s;
ok(defined $metal_row, 'bare-metal summary row rendered');
like($metal_row, qr/Spot VM\):\s*USD">\s*<\/td>/, 'summary has no fabricated Spot price');
like($metal_row, qr/Microsoft Windows Server:\s*USD">\s*<\/td>/, 'summary has no zero-dollar Windows license');
for my $file ('site/z4m-highmem-192-metal.html', 'site/us-central1/z4m-highmem-192-metal.html') {
	my $html = slurp($file);
	like($html, qr/<th>Microsoft Windows Server<\/th>\s*<td class="currency"><\/td>/, "$file leaves Windows unavailable");
	unlike($html, qr/<th>Spot provisioning model \(Spot VM\)<\/th>/, "$file omits unsupported Spot cost rows");
}
my $comparison = slurp('site/comparison/z4m-highmem-192-metal/vs/n2-standard-8.html');
like($comparison, qr/<th>Microsoft Windows Server<\/th>\s*<td class="currency table-active"><\/td>\s*<td>N\/A<\/td>/, 'comparison does not rank unavailable Windows as free');
like($comparison, qr/<th>Spot provisioning model \(Spot VM\)<\/th>\s*<td class="currency table-active"><\/td>\s*<td>N\/A<\/td>/, 'comparison does not rank unavailable Spot as free');
my $grid = decode_json(slurp('site/instance_in_region.json'));
my ($metal) = grep { $_->{name} eq 'z4m-highmem-192-metal' } @$grid;
ok(!defined $metal->{hourSpot} && !defined $metal->{monthSpot} && !defined $metal->{monthWindows}, 'grid JSON preserves NULL prices');

my $template = Template->new({ INCLUDE_PATH => "$build/src" });
my $source = '[% PROCESS macros.tt2 %][% tableCompareCosts(0, 1) %]';
my $zero_comparison;
$template->process(\$source, {}, \$zero_comparison) or die $template->error;
like($zero_comparison, qr/\+1\.0000/, 'legitimate zero costs still compare numerically');

done_testing();
