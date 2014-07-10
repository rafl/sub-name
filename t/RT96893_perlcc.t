use strict;
use warnings;

eval "use B::C;";
if ($@) {
  print "1..0 # SKIP B::C required for testing perlcc -O3\n";
  exit;
} else {
  print "1..1\n";
}

my $f = "t/rt96893x.pl";
open my $fh, ">", $f; END { unlink $f if $f }
print $fh 'use Sub::Name; subname("main::bar", sub{42}); print "ok 1\n";';
close $fh;

system($^X, qw(-Mblib -S perlcc -O3 -UCarp -UConfig -r), $f);

unlink "t/rt96893x", "t/rt96893x.exe";
# vim: ft=perl
