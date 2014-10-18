#!usr/bin/perl
use strict;
use warnings;
use IO::Socket;
use lib "C:/Users/Calcinatus/Documents/perl_test";
use Exporter qw(import);
#use webclient qw(connect get head chat);
use Gtk2 -init;
use constant TRUE =>1;
use Constant FALSE=>0;

our @EXPORT_OK = qw(server );

sub server {
	my ($port) = @_;
	our $socket = new IO::Socket::INET (
		LocalPort => "$port",
		Type => SOCK_STREAM,
		Reuse => 1,
		Listen => 10,
	); 
	die print "Could not create server.\n";
	print "Listening on port $port.\n";
	my $client;
	while($client = $socket->accept()) {
		$client->autoflush(1);
		our $line = <$client>;
		if ($line =~ /!chat/) {
			my $window = Gtk2::ScrolledWindow->new(undef, undef);
				$window->set_title("Chat Window.");
				$window->set_policy('automatic', 'automatic');
				$window->set_size_request(400, 500);
				$window->set_border_width(5);
			my $VBox = Gtk2::VBox->new();
			my $textview = Gtk2::TextView->new();
			my $textbuffer = Gtk2::TextBuffer->new();
				$textview->set_buffer($textbuffer);
				$textview->set_editable(0);
				$textview->set_wrap_mode('char');
			my $textframe = Gtk2::Frame->new();
				$textframe->set_border_width(4);
				$textframe->set_title("Chat.");
				$textbuffer->append_text($line);
			my $sendtextview = Gtk2::TextView->new();
			my $sendtextbuffer = Gtk2::TextBuffer->new();
				$sendtextview->set_buffer($sendtextbuffer);
				$sendtextview->set_editable(1);
				$sendtextview->set_wrap_mode('char');
			my $sendtextframe = Gtk2::Frame->new();
				$sendtextframe->set_title("Text to send.");
				$sendtextframe->set_border_width(4);
			my $chatbutton = Gtk2::Button->new();
				$chatbutton->set_label("Send");
				$chatbutton->signal_connect(clicked => sub{
					my $startiter = $sendtextbuffer->get_start_iter;
					my $enditer = $sendtextbuffer->get_end_iter;
					my $texttosend = $sendtextbuffer->get_text($startiter, $enditer);
					$socket->send($texttosend);
					}
				);
			$textframe->add($textview);
			$sendtextframe->add($sendtextview);
			$VBox->add($textframe);
			$VBox->add($sendtextframe);
			$VBox->add($chatbutton);
			$window->add($VBox);
			$window->show_all;
			Gtk2->main;
		}
		else {
			print "$line\n";
		}
	}
	close $socket;
}


	

