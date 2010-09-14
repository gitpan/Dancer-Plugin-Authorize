#!/usr/bin/env perl
use lib '../lib';
use Plack::Handler::FCGI;
use FindBin;
my $app = do($FindBin::Bin . '/../Test.pl');
my $server = Plack::Handler::FCGI->new(nproc  => 5, detach => 1);
$server->run($app);
