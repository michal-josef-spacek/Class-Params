# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Params qw(params);
use English;
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 5;
use Test::NoWarnings;

# Test.
my $self = {};
my $def_hr = {};
eval {
	params($self, $def_hr, ['foo', 'bar']);
};
is($EVAL_ERROR, "Unknown parameter 'foo'.\n", "Unknown parameter 'foo'.");
clean();

# Test.
$def_hr = {
	'foo' => ['_foo', undef, 'SCALAR', 0],
};
params($self, $def_hr, ['foo', 'bar']);
is_deeply(
	$self,
	{
		'_foo' => 'bar',
	},
	"Right check for parameter 'foo'.",
);
$self = {};

# Test.
$def_hr = {
	'foo' => ['_foo', undef, 'SCALAR', 1],
	'bar' => ['_bar', undef, 'SCALAR', 0],
};
eval {
	params($self, $def_hr, ['bar', 'baz']);
};
is($EVAL_ERROR, "Parameter 'foo' is required.\n", "Parameter 'foo' is required.");
clean();
$self = {};

# Test.
$def_hr = {
	'foo' => ['_foo', undef, 'SCALAR', 1],
};
params($self, $def_hr, ['foo', 'bar']);
is_deeply(
	$self,
	{
		'_foo' => 'bar',
	},
	"Right check for required parameter 'foo'.",
);
