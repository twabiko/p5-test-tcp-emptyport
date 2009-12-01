use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Test::TCP::EmptyPort',
    license             => 'perl',
    dist_author         => 'Takuma WABIKO <wabiko.takuma@gmail.com>',
    dist_version_from   => 'lib/Test/TCP/EmptyPort.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'Test-TCP-EmptyPort-*' ],
);

$builder->create_build_script();
