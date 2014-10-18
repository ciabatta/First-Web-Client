package webclient;

use warnings;
use strict;
use IO::Socket;
use Switch;
use Exporter qw(import);
use webserver qw(server);
use lib "C:/Users/Calcinatus/Documents/perl_test";
use constant TRUE =>1;
use Constant FALSE=>0;

our @EXPORT_OK = qw(connect get head chat);

sub chat{
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
		my $chat = "!chat";
		$socket->send($chat);
		#Below is for reference only. Need to get rid of it later.
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
					$socket->recv($rcvdata, 5000);
					print "$rcvdata\n";
			}
		}
	}
	print "Connection killed!";
	#Above is for reference only, need to get rid of it.
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
	if ($switch eq "-s") {
			my $dir = dir("/pages");
			my $file = $dir->file("index.html");
			my $filehandle = $file->openw();
			print $socket "GET /index.html\n";
			$socket->flush();
			while (my @page = <$socket>) {
					foreach my $lines (@page) {
						$filehandle->print($lines);
					}
				}
		}
	elsif ($switch eq "-p") {
	print $socket "GET /index.html HTTP/1.0\r\n";
	print $socket "Accept: image/gif\r\n";
	print $socket "Accept: image/jpg\r\n";
	print $socket "Accept: image/png\r\n";
	print $socket "Accept: image/x-xbitmap\t\n";
	$socket->flush();
		while (my $page = <$socket>) {
			print "$page\n";
		}
	}
	else {
		print "Invalid switch!";
	}
	close $socket;
}

sub head {
	my ($headaddress, $switch) = @_;
	$| = 1;
	my $socket = new IO::Socket::INET (
		PeerHost => "$headaddress",
		PeerPort => 80,
		Proto => "tcp",
	);
	die "Could not get head from $headaddress...\n Heh, get head, lol!\n";
	print "Getting head from $headaddress, lol.\n";
	if ($switch eq "-s") {
		my $dir = dir("/site");
		my $file = dir->file("header");
		my $filehandle = $file->openw();
		print $socket "HEAD /index.html HTTP/1.0\r\n";
		$socket->flush();
		while (my @header = <$socket>) {
			foreach my $lines (@header) {
				$filehandle->print($lines);
			}
		}
	}
	elsif ($switch eq "-p") {
		print $socket "HEAD /index.html HTTP/1.0\r\n";
		$socket->flush();
		while (my $header = <$socket>) {
			print "$header\n";
		}
	}
	 else  {
		print "Invalid switch.\n";
		  }
} 

sub connect {
		my ($sendaddress, $sendport) = @_;
		print "$sendaddress\n";
		print "$sendport\n";
		$| = 1;
		my $socket = new IO::Socket::INET (
			PeerHost => "$sendaddress",
			PeerPort => "$sendport",
			Proto => "tcp",
		);
		die "Cannot connect to the server $!\n" unless $socket;
		print "Connected to the server at $sendaddress on port $sendport.";
		while(42) {
			my $request = <STDIN>;
			switch ($request) {
				case("!kill") {
					close $socket;
					last
				}
				else {
					print $socket "$request /HTTP:1.1\r\n";
					$socket->flush();
				}
			}
		}
	print "Connection closed!";
}

1;















