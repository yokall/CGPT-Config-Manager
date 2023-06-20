use strict;
use warnings;

use Test::Simple tests => 4;

# Include the ConfigManager module
use lib '/home/colin/chat-gpt-config-manager';
use ConfigManager;

# Test data
my $config_data = {
    'file' => {
        'level' => 'filelevel'
    },
    'level' => 'top_level_value'
};

# Create a new ConfigManager instance
my $config_manager = ConfigManager->new($config_data);

# Test case 1: Retrieving a value by key
my $file_level = $config_manager->get_value_by_key('file.level');
ok( $file_level eq 'filelevel',
    'Value retrieved correctly for key "file.level"' );

# Test case 2: Retrieving a value by top-level key
my $top_level_value = $config_manager->get_value_by_key('level');
ok( $top_level_value eq 'top_level_value',
    'Value retrieved correctly for top-level key "level"' );

# Test case 3: Retrieving a value with fallback to previous level key
my $console_level = $config_manager->get_value_by_key('console.level');
ok( $console_level eq 'top_level_value',
    'Value fallback to "level" key for "console.level"' );

# Test case 4: Retrieving a non-existent key with fallback
my $nonexistent_fallback =
  $config_manager->get_value_by_key('console.nonexistent');
ok( !defined($nonexistent_fallback),
    'Value is undefined for non-existent key with fallback' );

