package ConfigManager;

use strict;
use warnings;

sub new {
    my ($class) = @_;
    my $self = {
        config => {
            file => {
                level => "default_value1",
            },
            level   => "default_value2",
            option3 => "default_value3",
        },
    };
    bless $self, $class;
    return $self;
}

sub get_option {
    my ( $self, $option_name ) = @_;
    my @keys  = split( /\./, $option_name );
    my $value = $self->_get_value_from_keys( \@keys, $self->{config} );

    # If the value is not found, try to find a fallback value
    unless ( defined $value ) {
        my $fallback_value =
          $self->_get_fallback_value( \@keys, $self->{config} );
        $value = $fallback_value if defined $fallback_value;
    }

    return $value;
}

sub _get_fallback_value {
    my ( $self, $keys, $config ) = @_;

    my $fallback_key = pop @$keys;
    if ( exists $config->{$fallback_key} ) {
        return $config->{$fallback_key};
    }
    else {
        return undef;
    }
}

sub _get_value_from_keys {
    my ( $self, $keys, $config ) = @_;
    my $value = $config;

    foreach my $key (@$keys) {
        if ( ref($value) eq 'HASH' && exists $value->{$key} ) {
            $value = $value->{$key};
        }
        else {
            $value = undef;
            last;
        }
    }

    return $value;
}

sub set_option {
    my ( $self, $option_name, $option_value ) = @_;
    my @keys       = split( /\./, $option_name );
    my $config_ref = $self->{config};
    for my $i ( 0 .. $#keys - 1 ) {
        my $key = $keys[$i];
        $config_ref->{$key} ||= {};
        $config_ref = $config_ref->{$key};
    }
    $config_ref->{ $keys[-1] } = $option_value;
}

1;
