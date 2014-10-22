package webclient;

use warnings;
use strict;
use Path::Class;
use IO::Socket;
use Exporter qw(import);
use constant TRUE =>1;
use Constant FALSE=>0;

our @EXPORT_OK = qw(connect get head post);

sub get {
	my ($getaddress, $switch) = @_;
	$| = 1;
	my $socket = new IO::Socket::INET (
		PeerHost => "$getaddress",
		PeerPort => 80,
		Proto => "tcp",
	);
	die "Could not GET the page $!\n" unless $socket;
	print "Retrieving $getaddress!\n";
	if ($switch eq "-s") {
		my $dir = dir("/pages");
		my $file = $dir->file("index.htm");
		my $filehandle = $file->openw();
		print $socket "GET / HTTP/1.0\r\n";
		print $socket "Accept: image/gif\r\r";
		print $socket "Accept: image/jpg\r\r";
		print $socket "Accept: image/png\r\r";
		print $socket "Accept: image/x-xbitmap\r\r";
		$socket->flush();
		while (my @page = <$socket>) {
				foreach my $lines (@page) {
					$filehandle->print($lines);
				}
			}
	}
	elsif ($switch eq "-p") {
	print $socket "GET / HTTP/1.0\r\r";
	print $socket "Accept: image/gif\r\r";
	print $socket "Accept: image/jpg\r\r";
	print $socket "Accept: image/png\r\r";
	print $socket "Accept: image/x-xbitmap\r\r";
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

sub post {
	my ($postaddress, $postswitch, $values) = @_;
		my @keyvalues = split(/;/, $values);
		print "$postaddress\n";
		print "$postswitch\n";
		print "@keyvalues\n";
		my $socket = new IO::Socket::INET (
			PeerHost => "$postaddress",
			PeerPort => 80,
			Proto => "tcp",
		);
		die "Could not connect to $!\n" unless $socket;
		if ($postswitch eq "-s") {
			my $dir = dir("/pages");
			my $file = $dir->file("index.htm");
			my $filehandle = $file->openw();
			my $postvalues = join("&", @keyvalues);
			print $socket "POST / HTTP/1.0\r\r";
			print $socket "Host: $postaddress\r\r";
			print $socket "$postvalues\r\r";
			$socket->flush();
			while (my @page = <$socket>) {
				foreach my $lines (@page) {
					$filehandle->print($lines);
				}
			}
		}
		elsif ($postswitch eq "-p") {
			my $postvalues = join("&", @keyvalues);
			print $socket "POST / HTTP/1.0\r\r";
			print $socket "Host: $postaddress\r\r";
			print $socket "$postvalues\r\r";
			$socket->flush();
			while (my $page = <$socket>) {
				print "$page\n";
			}
		}
		else {
			print "Invalid switch!\n";
		}
		close $socekt;
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
		print $socket "HEAD / HTTP/1.0\r\n";
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
		if ($request eq "kill") {
			close $socket;
			print "Connection killed.\n";
			last
		}
		else {
			print $socket "$request /HTTP:1.0\r\n";
			$socket->flush();
		}
	}
	print "Connection closed!";
}

1;















