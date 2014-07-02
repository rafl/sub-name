use 5.006;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> 'Sub::Name',
	VERSION_FROM	=> 'lib/Sub/Name.pm',
	ABSTRACT_FROM	=> 'lib/Sub/Name.pm',
	AUTHOR		=> 'Matthijs van Duin <xmath@cpan.org>'
);

package MY;
sub depend { "
README : \$(VERSION_FROM)
	pod2text \$(VERSION_FROM) > README"
}
