use inc::Module::Install;

# Define metadata
name           'Test-TCP-EmptyPort';
all_from       'lib/Test/TCP/EmptyPort.pm';

# Specific dependencies
test_requires  'Test::More';
test_requires  'Test::SharedFork' => '0.09';

WriteAll;
