use strict;
use warnings;
use Test::More;

use lib '/home/colin/chat-gpt-config-manager';

use ConfigManager;

# Create a new ConfigManager instance
my $config_manager = ConfigManager->new();

# Set option values
$config_manager->set_option( 'file.level', 'custom_value1' );
$config_manager->set_option( 'level',      'custom_value2' );

# Test the fallback behavior
is( $config_manager->get_option('file.level'),
    'custom_value1', 'multi level key' );
is( $config_manager->get_option('level'), 'custom_value2', 'root key' );
is( $config_manager->get_option('nonexistent.level'),
    'custom_value2', 'nonexistent root key falls back to 2nd key' );
is( $config_manager->get_option('nonexistent'),
    undef, 'A 1 part key that doesn\'t exisst should return undef' );
is( $config_manager->get_option('file.nonexistent'),
    undef, 'A 2 part key that doesn\'t exisst should return undef' );

done_testing();
