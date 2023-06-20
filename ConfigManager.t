use strict;
use warnings;

use Test::Simple tests => 3;

# Include the ConfigManager module
use lib '/home/colin/chat-gpt-config-manager';
use ConfigManager;

# Test data
my $config_data = {
    'file' => {
        'level' => 'filelevel'
    },
    'level' => 'level'
};

# Create a new ConfigManager instance
my $config_manager = ConfigManager->new($config_data);

# Test case 1: Retrieving a value by key
my $file_level = $config_manager->get_value_by_key('file.level');
ok( $file_level eq 'filelevel',
    'Value retrieved correctly for key "file.level"' );

# Test case 2: Retrieving a value by key (top-level key)
my $level = $config_manager->get_value_by_key('level');
ok( $level eq 'level', 'Value retrieved correctly for top-level key "level"' );

# Test case 3: Retrieving a value for a non-existent key
my $nonexistent = $config_manager->get_value_by_key('nonexistent');
ok( !defined($nonexistent), 'Value is undefined for non-existent key' );

