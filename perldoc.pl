#!/usr/bin/perl

use strict;
use warnings;

my $cmd   = <STDIN>;
my @lines = `perldoc -u -f $cmd`;

foreach (@lines) {
    print;
}
