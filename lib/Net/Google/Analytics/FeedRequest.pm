package Net::Google::Analytics::FeedRequest;
use strict;

# ABSTRACT: Google Analytics API feed request

use base qw(Class::Accessor);

__PACKAGE__->mk_accessors(qw(start_index max_results));

sub _params {
    return ();
}

1;



=pod

=head1 NAME

Net::Google::Analytics::FeedRequest - Google Analytics API feed request

=head1 VERSION

version 0.11001

=head1 DESCRIPTION

This is a base class for feed requests of the Google Analytics Data Export
API. Account feed requests are implemented in this class. Data feed requests
are implemented in L<Net::Google::Analytics::DataFeedRequest>.

=head1 ATTRIBUTES

=head2 start_index

=head2 max_results

=head1 AUTHOR

Nick Wellnhofer <wellnhofer@aevum.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Nick Wellnhofer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


