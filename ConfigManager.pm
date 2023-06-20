package ConfigManager;

sub new {
    my ( $class, $config_data ) = @_;
    my $self = { config_data => $config_data };
    bless $self, $class;
    return $self;
}

sub get_value_by_key {
    my ( $self, $key ) = @_;
    my @keys  = split( /\./, $key );
    my $value = $self->{config_data};
    foreach my $k (@keys) {
        if ( exists $value->{$k} ) {
            $value = $value->{$k};
        }
        else {
            return $self->fallback_value( \@keys );
        }
    }
    return $value;
}

sub fallback_value {
    my ( $self, $keys ) = @_;
    return undef if scalar(@$keys) < 2;
    shift @$keys;    # Discard the first element in the keys array
    return $self->get_value_by_key( join( '.', @$keys ) );
}

1;                   # End of package
