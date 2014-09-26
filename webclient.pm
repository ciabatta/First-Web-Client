package Web::Client;

#!usr/bin/perl
use warnings;
use strict;
use IO::Socket;

sub new {
	my $class = shift
	my $self = {
		_getaddress => shift;
		_getpage => shift;
		_savedata => shift;
		_headrequest =>shift;
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
	print ($socket "GET /HTTP/1.1\r\n");
	print ($socket "Host: "$getaddress[0]."\r\n");
	my @getpage = <$socket>;
	$self => {_getpage} = $getpage if defined $getpage;
	print while <$socket>;
	close($socket);
}

sub head {
	my ($self, $headrequest) = @_;
	my $self=>{_headrequest} = $headrequest if defined $headrequest;
	my $socket = new IO::Socket::INET ( 
			PeerAddr => "$headrequest[0]";
			PeerPort => "$headrequest[1]";
			Proto => "tcp";
	)
	die "Could not create socket: $!\n" unless $socket;
	print ($socket "HEAD /HTTP/1.1\r\n");
	my @head = <$socket>;
	$self=>{_head} = @head if defined @head;
	print while <$socket>;
	close($socket);
{

#Hey! Update this method to handle conditional saving!
#Updated! Thanks for the reminder.
sub save_page {
	my ($self, $savedata) =@_;
	$self=>{_savedata} = $savedata if defined $savedata;
	my $saveaddress = $savedata[0];
	my $filename = $savedata[1];
	my @page = $self=>{_getpage} if defined $self=>{_getpage};
	if ($saveaddress = "-c") {
		my $address = dir("/pages");
		my $filename = $address->file($address."/.html");
		my $filehandle = $filename->openw();
		foreach my $lines (@page) {
			$filehandle->print($lines."\n");
		}
	}
	else {
		my $address = dir($saveaddress."/pages");
		my $filename = $address->file($address."/.html");
		my $filehandle = $filename->openw();
		foreach my $lines (@page) {
			$filehandle->print($lines."\n");
		}
	}
}















