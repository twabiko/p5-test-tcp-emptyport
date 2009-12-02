use inc::Module::Install;

# Define metadata
name           'Test-TCP-EmptyPort';
all_from       'lib/Test/TCP/EmptyPort.pm';

# Specific dependencies
requires       'IO::Socket::INET';
test_requires  'Test::More';
test_requires  'Test::SharedFork' => '0.09';
test_requires  'IO::Socket::INET';
test_requires  'IO::Select';

WriteAll;
