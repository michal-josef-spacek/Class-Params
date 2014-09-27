#!/usr/bin/env perl

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