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
    my $value = $self->{config};
    foreach my $key (@keys) {
        if ( ref($value) eq 'HASH' && exists $value->{$key} ) {
            $value = $value->{$key};
        }
        else {
            $value = $self->{config}->{$key};
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

sub save_config {
    my ( $self, $file_path ) = @_;
    open( my $fh, '>', $file_path ) or die "Could not open file: $!";
    $self->_write_config( $fh, $self->{config} );
    close($fh);
}

sub _write_config {
    my ( $self, $fh, $config, $prefix ) = @_;
    $prefix ||= '';
    foreach my $key ( keys %$config ) {
        my $value = $config->{$key};
        if ( ref($value) eq 'HASH' ) {
            $self->_write_config( $fh, $value, "$prefix$key." );
        }
        else {
            print $fh "$prefix$key=$value\n";
        }
    }
}

1;