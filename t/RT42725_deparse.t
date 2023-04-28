use strict;
use warnings;

use Test::More tests => 2;
use if $ENV{AUTHOR_TESTING}, 'Test::Warnings';
use Sub::Name;
use B::Deparse;

my $source = eval {
    B::Deparse->new->coderef2text(subname foo => sub{ @_ });
};

ok !$@;

like $source, qr/\@\_/;
