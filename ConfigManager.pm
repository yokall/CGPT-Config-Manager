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
            $value = $value->{$k};
        }
    };
    return $value unless $@;
    return undef;
}

1;    # End of package
