#!/usr/bin/perl
#This script can be used to check if particular perl modules are installed or not 
use 5.010;
use strict;
use warnings;

my @modules = qw(
    Bit::Vector
    Carp::Clan
    Check::ISA
    DBD::Oracle
    DBI
    Tree::Simple
);

for(@modules) {
    eval "use $_";
    if ($@) {
        warn "Not found : $_" if $@;
    } else {
        say "Found : $_";
    }
}
