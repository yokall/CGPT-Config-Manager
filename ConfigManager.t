use strict;
use warnings;
use Test::More;

use lib '/home/colin/chat-gpt-config-manager';

use ConfigManager;

# Create a new ConfigManager instance
my $config_manager = ConfigManager->new();

# Set option values
$config_manager->set_option('file.level', 'custom_value1');
$config_manager->set_option('level', 'custom_value2');
$config_manager->set_option('option3', 'custom_value3');

# Test the fallback behavior
is($config_manager->get_option('file.level'), 'custom_value1', 'multi level key');
is($config_manager->get_option('level'), 'custom_value2', 'root key');
is($config_manager->get_option('option3'), 'custom_value3', 'option3 key exists');
is($config_manager->get_option('nonexistent.level'), 'custom_value2', 'nonexistent root key falls back to 2nd key');

# Save configuration to a file
$config_manager->save_config('config.txt');

done_testing();
