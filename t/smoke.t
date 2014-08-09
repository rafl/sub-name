#!/usr/bin/perl

BEGIN { print "1..10\n"; $^P |= 0x210 }


use Sub::Name;

my $x = subname foo => sub { (caller 0)[3] };
my $line = __LINE__ - 1;
my $file = __FILE__;
my $anon = $DB::sub{"main::__ANON__[${file}:${line}]"};

print $x->() eq "main::foo" ? "ok 1\n" : "not ok 1\n";


package Blork;

use Sub::Name;

subname " Bar!", $x;
print $x->() eq "Blork:: Bar!" ? "ok 2\n" : "not ok 2\n";

subname "Foo::Bar::Baz", $x;
print $x->() eq "Foo::Bar::Baz" ? "ok 3\n" : "not ok 3\n";

subname "subname (dynamic $_)", \&subname  for 1 .. 3;

for (4 .. 5) {
	subname "Dynamic $_", $x;
	print $x->() eq "Blork::Dynamic $_" ? "ok $_\n" : "not ok $_\n";
}

print $DB::sub{"main::foo"} eq $anon ? "ok 6\n" : "not ok 6\n";

for (4 .. 5) {
	print $DB::sub{"Blork::Dynamic $_"} eq $anon ? "ok ".($_+3)."\n" : "not ok ".($_+3)."\n";
}

my $i = 9;
for ("Blork:: Bar!", "Foo::Bar::Baz") {
	print $DB::sub{$_} eq $anon  ? "ok $i\n" : "not ok $_ \n";
	$i++;
}

# vim: ft=perl
