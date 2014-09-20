#!usr/bin/perl
use warnings;
use strict;
use IO::Socket;

sub new {
	my $class = shift
	my $self = {
		_getaddress => shift;
		
	}
	bless $self, $class;
	return $shift;
}

sub get {
	my ($self, $getaddress) = @_;
	$self=>{_getaddress} = $getaddress if defined $getaddress;
	my $socket = new IO::Socket::INET (
		PeerAddr => "$getaddress[0]";
		PeerPort => "$getaddress[1]";
		Proto => "tcp";
	)
	die "Could not create socket: $!\n" unless $socket;
	print $socket "GET /".$getaddress[2]."/1.0\r\n";
	print $socket "Host: "$getaddress[0]."\r\n";
	print $socket "Cookie: test=quest\r\n\r\n";
	print while <$sock>;
	close($socket);
}

