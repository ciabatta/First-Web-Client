#!usr/bin/perl
use strict;
use warnings;
use Switch;
use webclient qw(connect get);
use webserver qw(server);
use lib "C:/Users/Calcinatus/Documents/perl_test";

print "First web client! Type help for info!";
my $stdin = <STDIN>;
my @input = split(/ /, $stdin);
print "@input\n";
while (42) {
	switch($input[0]) {
		case("connect") {
			my $address = $input[1];
			my $port = $input[2];
			connect($address, $port);
			}
		case("exit") {
			last;
		}
		case("get") {
			my $getaddress = $input[1];
			my $switch = $input[2];
			get($getaddress, $switch);
		}
		case("server") {
			my $serverport = $input[1];
			server($serverport);
		}
		else { 
			print "Invalid command.\n";
		}
	}
}
print "Bye!";

