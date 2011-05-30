# Pragmas.
use strict;
use warnings;

# Modules.
use ExtUtils::MakeMaker;

# Definition.
WriteMakefile(
	'AUTHOR' => 'Michal Spacek',
	'NAME' => 'Class::Params',
	'PREREQ_PM' => {
		'Error::Simple::Multiple' => 0.05,
	},
	'VERSION' => 0.01,
	'test' => {
		'TESTS' => 't/Class::Params/*.t',
	},
);
