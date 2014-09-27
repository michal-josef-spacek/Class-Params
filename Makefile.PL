# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Parameter utils for constructor.';
author 'Michal Špaček <skim@cpan.org>';
license 'bsd';
name 'Class-Params';
readme_from 'Params.pm';
requires 'Error::Pure' => 0.16;
requires 'Exporter' => 0;
requires 'Readonly' => 0;
requires 'Scalar::Util' => 0;
requires 'perl' => '5.8.0';
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=Class-Params';
resources 'homepage' => 'https://github.com/tupinek/Class-Params';
resources 'repository' => 'git://github.com/tupinek/Class-Params';
test_requires 'English' => 0;
test_requires 'File::Object' => 0.07;
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.02';

# Run.
WriteAll();
