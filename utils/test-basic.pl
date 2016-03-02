#!/usr/bin/perl

use strict;
use warnings;
use Rtpengine::Test;
use IO::Socket;

my $r = Rtpengine::Test->new();
my $a = $r->client(domain => &Socket::AF_INET);
my $b = $r->client(domain => &Socket::AF_INET);

$r->timer_once(3, sub { $b->answer($a, ICE => 'remove'); $a->start_rtp(); });
$r->timer_once(10, sub { $r->stop(); });

$a->offer($b, ICE => 'remove');
$b->start_rtp();

$r->run();

$a->delete();