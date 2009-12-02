#!perl -T
use strict;
use warnings;
use Test::More tests => 3;
use Test::TCP::EmptyPort qw(empty_port);
use Test::SharedFork;
use IO::Socket::INET;
use IO::Select;

my $port = empty_port();
diag("port: $port/tcp");
ok(1024 < $port);

my $pid = fork();
if ($pid == 0) {
    # child
    my $servsock = IO::Socket::INET->new(
        Listen => 5,
        LocalAddr => '127.0.0.1',
        LocalPort => $port,
        Proto => 'tcp',
        Reuse => 1,
    ) or die $!;
    my $sock = $servsock->accept;
    chomp(my $line = <$sock>);
    ok($line =~ /client/);
    print $sock "Hello! I am server! ;)\n";
    $sock->close;
    $servsock->close;
    waitpid($pid, 0);
} elsif ($pid) {
    # parent
    my $sock = IO::Socket::INET->new(
        PeerAddr => '127.0.0.1',
        PeerPort => $port,
        Proto => 'tcp',
    ) or die $!;
    print $sock "Hello! I am client! :)\n";
    for (1 .. 5) {
        if (IO::Select->new($sock)->can_read(1)) {
            chomp(my $line = <$sock>);
            ok($line =~ /server/);
            last;
        }
    }
    $sock->close;
} else {
    BAIL_OUT($!);
}
__END__
