use Test::More tests => 3;
use Test::TCP::EmptyPort qw(empty_port);
use Test::SharedFork;

my $port = empty_port();
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
    );
    ok(my $sock = $servsock->accept);
    print $sock "testing Test::TCP::EmptyPort\n";
    $sock->close;
    $servsock->close;
} elsif ($pid) {
    # parent
    sleep 3; # XXX
    my $sock = IO::Socket::INET->new(
        PeerAddr => '127.0.0.1',
        PeerPort => $port,
        Proto => 'tcp',
    );
    while (my $line = <$sock>) {
        ok($line =~ /testing Test::TCP::EmptyPort/);
    }
} else {
    BAIL_OUT($!);
}

__END__
