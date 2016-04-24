use strict;
use warnings;
use lib 'inc';
use ExtUtils::MakeMaker::Dist::Zilla::Develop;

$ENV{PERL_MM_OPT} = 'NORECURS=1';

WriteMakefile(
    NAME => 'Sub::Name',
    VERSION_FROM => 'lib/Sub/Name.pm',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
);
