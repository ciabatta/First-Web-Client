package webclient;

use warnings;
use strict;
use IO::Socket;
use Switch;
use Exporter qw(import);

our @EXPORT_OK = qw(connect send);

sub connect{
		my ($getaddress, $getport) = @_;
		print "$getaddress\n";
		print "$getport\n";
		$| = 1;
		my $socket = new IO::Socket::INET (
			PeerHost => "$getaddress",
			PeerPort => "$getport",
			Proto => "tcp",
		);
		die "Cannot connect to the server $!\n" unless $socket;
		print "Connected to the server at $getaddress on port $getport.";
		while (42) {
				my $message = <STDIN>;
				switch($message) {
					case("kill") {
					close($socket);
					print "Connection killed!";
					last;
				}	
				else {
					my $rcvdata;
					$socket->send($message);
					$socket->recv($rcvdata, 10);
					print "$rcvdata\n";
			}
		}
	}
}



1;















