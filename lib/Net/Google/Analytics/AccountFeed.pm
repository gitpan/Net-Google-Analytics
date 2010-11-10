package Net::Google::Analytics::AccountFeed;
BEGIN {
  $Net::Google::Analytics::AccountFeed::VERSION = '0.11002';
}
use strict;

# ABSTRACT: Google Analytics API account feed

use base qw(Net::Google::Analytics::Feed);

use Net::Google::Analytics::FeedRequest;
use Net::Google::Analytics::AccountFeedResponse;

sub _base_url {
    return 'https://www.google.com/analytics/feeds/accounts/default';
}

sub _max_items_per_page {
    return 1_000;
}

sub new_request {
    return Net::Google::Analytics::FeedRequest->new();
}

sub _new_response {
    return Net::Google::Analytics::AccountFeedResponse->new();
}

1;



=pod

=head1 NAME

Net::Google::Analytics::AccountFeed - Google Analytics API account feed

=head1 VERSION

version 0.11002

=head1 DESCRIPTION

This package is a subclass of L<Net::Google::Analytics::Feed> and
implements account feeds of the Google Analytics Data Export API.

=head1 METHODS

=head2 new_request

 my $req = $account_feed->new_request();

Creates and returns a L<Net::Google::Analytics::FeedRequest> object.

=head2 retrieve

 my $res = $account_feed->retrieve($req);

Retrieves the account feed. Returns a
L<Net::Google::Analytics::AccountFeedResponse> object.

=head1 AUTHOR

Nick Wellnhofer <wellnhofer@aevum.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Nick Wellnhofer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


