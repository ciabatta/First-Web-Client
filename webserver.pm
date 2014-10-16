#!usr/bin/perl
use strict;
use warnings;
use IO::Socket;
use Exporter qw(import);

our @EXPORTER_OK = qw(server );

sub server {
	my ($port) = @_;
	my $server = new IO::Socket::INET (
		LocalPort => "$port",
		Type => SOCK_STREAM,
		Reuse => 1,
		Listen => 10,
	) or die;
	my $client;
	while($client = $server->accept()) {
		my $line = <$client>;
		print "$line\n";
	}
	close $server;
}