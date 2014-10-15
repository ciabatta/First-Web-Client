#!usr/bin/perl
use strict;
use warnings;
use IO::Socket;
use Exporter qw(import);

our @EXPORTER_OK(server );

sub server {
	my ($port, $type) = @_;
	my $server = new IO::Socket::INET (
		LocalPort => $port;
		Type => SOCK_STREAM;
		Reuse => 1;
		Listen => 10;
	) or die;
	my $clinet;
	while($client = $server->accept) {
		print $client;
	}
}