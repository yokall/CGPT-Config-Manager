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
    eval {
        foreach my $k (@keys) {
            if ( exists $value->{$k} ) {
                $value = $value->{$k};
            }
            else {
                # Fallback to the previous level key
                shift @keys;
                return $self->get_value_by_key( join( '.', @keys ) );
            }
        }
    };
    return $value unless $@;
    return undef;
}

1;    # End of package
