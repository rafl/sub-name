# $Id: Name.pm,v 1.4 2004/08/18 12:03:42 xmath Exp $

package Sub::Name;

=head1 NAME

Sub::Name - (re)name a sub

=head1 SYNOPSIS

    use Sub::Name;

    subname $name, $subref;

    $subref = subname foo => sub { ... };

=head1 DESCRIPTION

This module has two functions to assign a new name to a sub -- in particular an 
anonymous sub -- which is displayed in tracebacks and such.  Both functions are 
exported by default.

=head2 subname NAME, CODEREF

Assigns a new name to referenced sub.  If package specification is omitted in 
the name, then the current package is used.  The return value is the sub.

The name is only used for informative routines (caller, Carp, etc).  You won't 
be able to actually invoke the sub by the given name.  To allow that, you need 
to do glob-assignment yourself.

Note that for closures (anonymous subs that reference lexicals outside the sub 
itself) you can name each instance of the closure differently, which can be 
very useful for debugging.

=head1 AUTHOR

Matthijs van Duin <xmath@cpan.org>

Copyright (C) 2004  Matthijs van Duin.  All rights reserved.
This program is free software; you can redistribute it and/or modify 
it under the same terms as Perl itself.

=cut

use 5.006;

use strict;
use warnings;

our $VERSION = '0.01';

use base 'Exporter';
use base 'DynaLoader';

our @EXPORT = qw(subname);
our @EXPORT_OK = @EXPORT;

bootstrap Sub::Name $VERSION;

1;
