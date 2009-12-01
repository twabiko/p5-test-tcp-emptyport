package Test::TCP::EmptyPort;

use warnings;
use strict;
use Carp;
use version;
our $VERSION = qv('0.0.2');
use base qw/Exporter/;
our @EXPORT_OK = qw(tcp_empty_port empty_port);
use IO::Socket::INET;

our $PORT_MIN = 10000;
our $PORT_MID = 19000;
our $PORT_MAX = 20000;

sub tcp_empty_port {
    my $port = shift || $PORT_MIN;
    $port = $PORT_MID unless $port =~ /^[0-9]+$/ && $port < $PORT_MID;

    while ( $port++ < $PORT_MAX) {
        my $sock = IO::Socket::INET->new(
            Listen    => 5,
            LocalAddr => '127.0.0.1',
            LocalPort => $port,
            Proto     => 'tcp',
            (($^O eq 'MSWin32') ? () : (ReuseAddr => 1)),
        );
        return $port if $sock;
    }
    die "empty port not found";
}

sub empty_port {
    tcp_empty_port(@_);
}

1; # Magic true value required at end of module
__END__

=head1 NAME

Test::TCP::EmptyPort - find empty port for TCP program testing

=head1 SYNOPSIS

    use Test::TCP::EmptyPort qw(empty_port);

    my $port = empty_port();
    my $obj = Something->new(tcp_port => $port);

=for author to fill in:
    Brief code example(s) here showing commonest usage(s).
    This section will be as far as many users bother reading
    so make it as educational and exeplary as possible.
  
=head1 METHODS

=over 4

=item tcp_empty_port

    my $port = tcp_empty_port();

Get the available port number, you can use.

=item empty_port

Synonym for tcp_empty_port.

=back

=head1 AUTHOR

Takuma WABIKO  C<< <wabiko.takuma@gmail.com> >>

=head1 SEE ALSO

Test::TCP

Ah, Yes. Test::TCP has empty_port().
But Test::SharedFork distirbs line number that test failed.
And Test::TCP uses it. So I reinvented the wheel.

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2009, Takuma WABIKO C<< <wabiko.takuma@gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=cut
