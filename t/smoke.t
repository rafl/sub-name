#!/usr/bin/perl

BEGIN { print "1..3\n"; }


use Sub::Name;

my $x = subname foo => sub { (caller 0)[3] };
print $x->() eq "main::foo" ? "ok 1\n" : "not ok 1\n";


package Blork;

use Sub::Name;

subname " Bar!", $x;
print $x->() eq "Blork:: Bar!" ? "ok 2\n" : "not ok 2\n";

subname "Foo::Bar::Baz", $x;
print $x->() eq "Foo::Bar::Baz" ? "ok 3\n" : "not ok 3\n";


# $Id: smoke.t,v 1.4 2004/08/18 12:03:42 xmath Exp $
# vim: ft=perl
