use strict;
use warnings;

use Test::More 0.88;

plan skip_all => 'B::C required for testing perlcc -O3'
    unless eval "require B::C;";

plan skip_all => "B::C is too old (require 1.48, have $B::C::VERSION)"
    unless eval { B::C->VERSION('1.48') };

use Devel::CheckBin;
plan skip_all => 'perlcc required' unless can_run('perlcc');

my $f = "t/rt96893x.pl";
open my $fh, ">", $f; END { unlink $f if $f }
print $fh 'use Sub::Name; subname("main::bar", sub{42}); print "ok 1\n";';
close $fh;

system($^X, qw(-Mblib -S perlcc -O3 -UCarp -UConfig -r), $f);

unlink "t/rt96893x", "t/rt96893x.exe";

done_testing;
# vim: ft=perl
