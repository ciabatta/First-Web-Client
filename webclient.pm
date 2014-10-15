package webclient;

use warnings;
use strict;
use IO::Socket;
use Switch;
use Exporter qw(import);

our @EXPORT_OK = qw(connect get);

sub connect{
		my ($address, $port) = @_;
		print "$address\n";
		print "$port\n";
		$| = 1;
		my $socket = new IO::Socket::INET (
			PeerHost => "$address",
			PeerPort => "$port",
			Proto => "tcp",
		);
		die "Cannot connect to the server $!\n" unless $socket;
		print "Connected to the server at $address on port $port.";
		while (42) {
				my $message = <STDIN>;
				switch($message) {
					case("!kill") {
					close($socket);
					last;
				}	
				else {
					my $rcvdata;
					$socket->send($message);
					$socket->flush();
					$socket->recv($rcvdata, 10);
					print "$rcvdata\n";
			}
		}
	}
	print "Connection killed!";
}

sub get {
	my ($getaddress, $switch) = @_;
	$| = 1;
	my $socket = new IO::Socket::INET (
		PeerHost => "$getaddress",
		PeerPort => 80,
		Proto => "tcp",
	);
	die "Could not GET the page $!\n" unless $socket;
	print "Retrieving $getaddress!";
	if ($switch == "-s") {
			my $dir = dir("/pages");
			my $file = $dir->file("index.html");
			my $filehandle = $file->openw();
			print $socket "GET /index.html\n";
			while (my @page = <$socket>) {
					foreach my $lines (@page) {
						print $lines;
					}
				}
		}
	else {
	print $socket "GET /index.html\n";
		while (my $page = <$socket>) {
			print "$page\n";
		}
	}
	close $socket;
}

1;















