# Pragmas.
use strict;
use warnings;

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'AUTHOR' => 'Michal Špaček <skim@cpan.org>',
	'NAME' => 'Class::Params',
	'PREREQ_PM' => {
		'Error::Pure' => 0.01,
	},
	'VERSION' => 0.01,
	'test' => {
		'TESTS' => 't/Class::Params/*.t',
	},
);
