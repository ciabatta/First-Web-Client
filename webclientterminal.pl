#!usr/bin/perl
use strict;
use warnings;
use switch;
use Web::Client;

my $client = Web::Client->new();
print "First web client! Type help for info!"
my @input = <STDIN>;
switch($input[0]) {
	case ("get", "Get", "GET") {
		my @getdata = ($input[1], $input[2]);
		$client->get(@getdata);
	}
	case ("head", "Head", "HEAD") {
		my @headdata = ($input[1], $input[2]);
		$client->head(@headdata);
	}
	case ("save", "Save", "SAVE") {
		my @savedata = ($input[1], $input[0]);
		$client->save_page(@savedata);
	}
}
