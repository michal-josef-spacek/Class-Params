package Class::Params;

# Pragmas.
use base qw(Exporter);
use strict;
use warnings;

# Modules.
use Error::Pure qw(err);
use Readonly;
use Scalar::Util qw(blessed);

# Export.
Readonly::Array our @EXPORT_OK => qw(params);

# Version.
our $VERSION = 0.01;

# Params processing.
sub params {
	my ($self, $def, $input_array) = @_;

	# Process params.
	my @processed = ();
        while (@{$input_array}) {
                my $key = shift @{$input_array};
                my $val = shift @{$input_array};

		# Check key.
		if (! $def->{$key}->[0]) {
	                err "Unknown parameter '$key'.";
		}

		# Check type.
		if (! _check_type($val, $def->{$key}->[2])) {
			err "Bad parameter '$key' type.";
		}

		# Check class.
		if (! _check_class($val, $def->{$key}->[1])) {
			err "Bad parameter '$key' class.";
		}

		# Add value to class.
		$self->{$def->{$key}->[0]} = $val;

		# Processed keys.
		push @processed, $key;
        }

	foreach my $req (map { $def->{$_}->[3] ? $_ : () } keys %{$def}) {
		if (! grep { $req eq $_ } @processed) {
			err "Parameter '$req' is required.";
		}
	}
}

# Check type.
# Possible types: HASH, ARRAY, SCALAR.
sub _check_type {
	my ($value, $type) = @_;

	# Multiple types.
	if (ref $type eq 'ARRAY') {
		foreach (@{$type}) {
			if (_check_type_one($value, $_)) {
				return 1;
			}
		}
		return 0;

	# One type.
	} else {
		return _check_type_one($value, $type);
	}
}

# Check one type.
sub _check_type_one {
	my ($value, $type) = @_;
	if (ref $value eq $type 
		|| ref \$value eq $type) {

		return 1;
	} else {
		return 0;
	}
}

# Check class.
# Class: CLASS/undef.
sub _check_class {
	my ($value, $class) = @_;
	if ($class) {

		# Array.
		if (ref $value eq 'ARRAY') {
			foreach (@{$value}) {
				if (! _check_class($_, $class)) {
					return 0;
				}
			}
			return 1;
		# One.
		} else {
			return _check_type_one($value, $class);
		}
	} else {
		return 1;
	}
}

# Check ref to class.
sub _check_class_one {
	my ($ref, $class) = @_;
	if (! blessed ($ref) || ! $ref->isa($class)) {
		return 1;
	} else {
		return 0;
	}
}

1;

=pod

=encoding utf8

=head1 NAME

 Class::Params - Parameter utils for constructor.

=head1 SYNOPSIS

 use Class::Params qw(params);
 params($self, $def, $input_array);

=head1 DEFINITION FORMAT

 There is hash with parameters.
 internal_name => [real_name, class, possible_types, requirement]

 Example:
 'par1' => ['_par1', undef, 'SCALAR', 1],
 'par2' => ['_par2', undef, ['SCALAR', 'HASH'], 0],
 'par3' => ['_par3', 'Class', ['SCALAR', 'Class'], 0],

=head1 SUBROUTINES

=over 8

=item B<params($self, $def, $input_array)>

 Check for structure over definition and save input data to $self.
 Parameters:
 $self - Structure, for data save.
 $def - Definition hash ref.
 $input_array - Array of key-value pairs.

=back

=head1 EXAMPLE1

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Class::Params qw(params);

 # Definition.
 my $self = {};
 my $def = {
         'par' => ['par', undef, 'SCALAR', 1],
 };

 # Check.
 # output_structure, definition, array of pairs (key, value).
 params($self, $def, ['bad_par', 1]);

 # Output:
 # Unknown parameter 'bad_par'.

=head1 EXAMPLE2

 # Pragmas.
 use strict;
 use warnings;

 # Modules.
 use Class::Params qw(params);
 use Data::Printer;

 # Definition.
 my $self = {};
 my $def = {
         'par' => ['par', undef, 'SCALAR', 1],
 };

 # Check.
 # output_structure, definition, array of pairs (key, value).
 params($self, $def, ['par', 1]);

 # Dump $self.
 p $self;

 # Output:
 # \ {
 #     par   1
 # }

=head1 DEPENDENCIES

L<Error::Pure>,
L<Exporter>,
L<Readonly>,
L<Scalar::Util>.

=head1 REPOSITORY

L<https://github.com/tupinek/Class-Params>

=head1 AUTHOR

Michal Špaček L<skim@cpan.org>

=head1 LICENSE AND COPYRIGHT

BSD license.

=head1 VERSION

0.01

=cut
