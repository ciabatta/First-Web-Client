#!usr/bin/perl
use strict;
use warnings;
use webclient qw(connect get head post);
use constant TRUE =>1;
use Constant FALSE=>0;

print "First web client! Type help for info!";
terminal();
sub terminal {
	my $stdin = <STDIN>;
	chomp $stdin;
	my @input = split(/ /, $stdin);
		if ($input[0] eq "connect") {
			if ($input[1] eq "") {
				print "No address specified!\n";
				terminal();
			}
			elsif ($input[2] eq "") {
				print "No port specified!\n";
				terminal();
			}
			else {
				my $address = $input[1];
				my $port = $input[2];
				connect($address, $port);
				terminal();
			}
		}
			elsif ($input[0] eq "exit") {
				print "Bye!\n";
			}
			elsif ($input[0] eq "get") {
				if ($input[1] eq "") {
					print "No address specified!\n";
					terminal();
				}
				elsif ($input[2] eq "") {
					print "No switch used!\n";
					terminal();
				}
				else {
					my $getaddress = $input[1];
					my $getswitch = $input[2];
					get($getaddress, $getswitch);
					terminal();
				}
			}
			elsif($input[0] eq "head") {
				if ($input[1] eq "") {
					print "No address specified!\n";
					terminal();
				}
				elsif ($input[2] eq "") {
					print "No switch used!\n";
					terminal();
				}
				else {
					my $headaddress = $input[1];
					my $headswitch = [2];
					head($headaddress, $headswitch);	
					terminal();
				}
			}
			elsif($input[0] eq "help") {
				if ($input[1] eq "") {
					print "Please type help and a command.\n";
					print "Example: help get.\n";
					print "Type help commands for a list of commands.\n";
					terminal();
				}
				elsif ($input[1] eq "get") {
					print "Syntax: get address [-s][-p].\n";
					print "Address is the websites http address.\n";
					print "-s saves the page to the current directory.\n";
					print "-p prints the page to the terminal.\n";
				}
				elsif ($input[1] eq "head") {
					print "Syntax: head address [-s][-p].\n";
					print "Address is the websites http address.\n";
					print "-s saves the page to the current directory.\n";
					print "-p prints the page to the terminal.\n";
				}
				elsif ($input[1] eq "connect") {
					print "Syntax: connect address port.\n";
					print "Address is the http address of the website.\n";
					print "Port is the port you want to connect on.\n";
					print "If the connection is successful, you can write.\n";
					print "raw http to the server.\n";
				}
				elsif ($input[1] eq "commands") {
					print "Command List:\n";
					print "get\n";
					print "head\n";
					print "connect\n";
					print "help\n";
				}
			terminal();
			}
			elsif ($input[0] eq "post") {
				if ($input[1] eq "") {
					print "No address specified!\n";
					terminal();
				}
				elsif ($input[2] eq "") {
					print "No switch used!\n";
					terminal();
				}
				elsif ($input[3] eq "") {
					print "No key value pair specified!\n";
					terminal();
				}
				else {
					my $postaddress = $input[1];
					my $postswitch = $input[2];
					my $keyvalues = $input[3];
					post($postaddress, $postswitch, $keyvalues);
				}
			}
			else { 
				print "Invalid command.\n";
				terminal();
			}
		}


