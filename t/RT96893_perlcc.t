if (eval "require B::C;"
    and eval { B::C->VERSION('1.48') }
    and eval 'require Devel::CheckBin'
    and Devel::CheckBin::can_run('perlcc')
   )
{
  print "1..1\n";
  my $f = "t/rt96893x.pl";
  open my $fh, ">", $f; END { unlink $f if $f }
  print $fh 'use Sub::Name; subname("main::bar", sub{42}); print "ok 1\n";';
  close $fh;
  system($^X, qw(-Mblib -S perlcc -O3 -UCarp -UConfig -r), $f);
  unlink "t/rt96893x", "t/rt96893x.exe";
} else {
  print "1..0  # SKIP perlcc missing\n";
}
# vim: ft=perl
