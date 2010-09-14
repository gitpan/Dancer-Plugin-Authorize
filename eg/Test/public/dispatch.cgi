#!/usr/bin/env perl
use lib '../lib';
use Plack::Runner;
use FindBin;
Plack::Runner->run($FindBin::Bin . '/../Test.pl');
