#!/usr/bin/env perl
use strict;
use warnings;
use Plack::App::Directory;
my $app = Plack::App::Directory->new({
	root => "../site/"
})->to_app;