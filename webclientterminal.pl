#!usr/bin/perl
use strict;
use warnings;
use Switch;
use webclient qw(connect get head chat);
use webserver qw(server);
use lib "C:/Users/Calcinatus/Documents/perl_test";
use constant TRUE =>1;
use Constant FALSE=>0;

print "First web client! Type help for info!";
terminal();
sub terminal {
	my $stdin = <STDIN>;
	chomp $stdin;
	my @input = split(/ /, $stdin);
		if ($input[0] eq "connect") {
			my $address = $input[1];
			my $port = $input[2];
			connect($address, $port);
			}
			elsif ($input[0] eq "exit") {
				print "Bye!\n";
			}
			elsif ($input[0] eq "get") {
				my $getaddress = $input[1];
				my $getswitch = $input[2];
				get($getaddress, $getswitch);
			}
			elsif($input[0] eq "server") {
				my $serverport = $input[1];
				server($serverport);
			}
			elsif($input[0] eq "head") {
				my $headaddress = $input[1];
				my $headswitch = [2];
				head($headaddress, $headswitch);		
			}
			elsif($input[0] eq "chat") {
				my $sendaddress = $input[1];
				my $sendport = $input[2];
				chat($sendaddress, $sendport);	
			}
			else { 
				print "Invalid command.\n";
				terminal();
			}
		}


