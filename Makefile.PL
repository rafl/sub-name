use 5.006;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME            => 'Sub::Name',
    VERSION_FROM    => 'lib/Sub/Name.pm',
    ABSTRACT_FROM   => 'lib/Sub/Name.pm',
    AUTHOR          => 'Matthijs van Duin <xmath@cpan.org>',

    PREREQ_PM       => {
        'Exporter' => '0',
        'DynaLoader' => '0',
    },
    BUILD_REQUIRES  => {
        'Devel::CheckBin' => '0',
        'Test::More' => '0',
    },

    MIN_PERL_VERSION => '5.006',
    META_MERGE => {
        'meta-spec' => { version => 2 },
        dynamic_config => 0,
        resources => {
            repository => {
                url => 'https://github.com/karenetheridge/Sub-Name.git',
                web => 'https://github.com/karenetheridge/Sub-Name',
                type => 'git',
            },
            bugtracker => {
                mailto => 'bug-Sub-Name@rt.cpan.org',
                web => 'https://rt.cpan.org/Public/Dist/Display.html?Name=Sub-Name',
            },
        },
    },
);

package MY;
sub depend { "
README : \$(VERSION_FROM)
	pod2text \$(VERSION_FROM) > README"
}
