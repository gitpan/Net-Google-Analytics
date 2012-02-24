#!perl
use strict;

use Net::Google::Analytics;
use Net::Google::Analytics::OAuth2;

# Insert your numeric Analytics profile ID here. You can find it under
# profile settings. DO NOT use your account or property ID (UA-nnnnnn).
my $profile_id    = "9938193";
# See GETTING STARTED for how to get a client id, client secret, and
# refresh token
my $client_id     = "653030594325.apps.googleusercontent.com";
my $client_secret = "rokMAj3noz7boKKgM_NYt6mo";
my $refresh_token = "1/wiPJkRu4rveUTsg6YctDHifCu_8fVvZJz2kqWeQG58k";

my $analytics = Net::Google::Analytics->new;

# Authenticate
my $oauth = Net::Google::Analytics::OAuth2->new(
    client_id     => $client_id,
    client_secret => $client_secret,
);
my $token = $oauth->refresh_access_token($refresh_token);
$analytics->token($token);

# Build request
my $req = $analytics->new_request(
    ids         => "ga:$profile_id",
    dimensions  => "ga:medium,ga:source",
    metrics     => "ga:bounces,ga:visits",
    filters     => "ga:medium==referral",
    sort        => "-ga:visits",
    start_date  => "2011-10-01",
    end_date    => "2011-10-31",
    max_results => 5,
);

# Send request
my $res = $analytics->retrieve($req);
die("GA error: " . $res->error_message) if !$res->is_success;

# Print results

print
    "Results: 1 - ", $res->items_per_page,
    " of ", $res->total_results, "\n\n";

for my $row (@{ $res->rows }) {
    print
        $row->get_source,  ": ",
        $row->get_visits,  " visits, ",
        $row->get_bounces, " bounces\n";
}

print
    "\nTotal: ",
    $res->totals("visits"),  " visits, ",
    $res->totals("bounces"), " bounces\n";

