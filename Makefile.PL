# $Id: Makefile.PL,v 1.1 2004/08/17 19:23:24 xmath Exp $

use 5.006;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> 'Sub::Name',
	VERSION_FROM	=> 'lib/Sub/Name.pm',
	ABSTRACT_FROM	=> 'lib/Sub/Name.pm',
	AUTHOR		=> 'Matthijs van Duin <xmath@cpan.org>'
);
