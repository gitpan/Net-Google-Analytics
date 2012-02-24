#! perl
use strict;

use Net::Google::Analytics::OAuth2;

my $oauth = Net::Google::Analytics::OAuth2->new(
    client_id     => '653030594325.apps.googleusercontent.com',
    client_secret => 'rokMAj3noz7boKKgM_NYt6mo',
);

$oauth->interactive;

