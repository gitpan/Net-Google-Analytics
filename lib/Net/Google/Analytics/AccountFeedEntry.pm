package Net::Google::Analytics::AccountFeedEntry;
BEGIN {
  $Net::Google::Analytics::AccountFeedEntry::VERSION = '0.11003';
}
use strict;

# ABSTRACT: Google Analytics API account feed entry

use base qw(Class::Accessor Net::Google::Analytics::XML);

my @property_map = (
    account_id      => 'accountId',
    account_name    => 'accountName',
    profile_id      => 'profileId',
    web_property_id => 'webPropertyId',
    currency        => 'currency',
    timezone        => 'timezone',
);

__PACKAGE__->mk_accessors(qw(
    account_id account_name profile_id web_property_id currency timezone
    table_id title
));

sub _parse {
    my ($package, $node) = @_;

    my $self = {};
    my $xpc = $package->_xpc;

    for (my $i=0; $i<@property_map; $i+=2) {
        my $from = $property_map[$i+1];
        my $to   = $property_map[$i];

        $self->{$to} = $xpc->findvalue(
            "dxp:property[\@name='ga:$from']/\@value",
            $node
        );
    }

    $self->{table_id} = $xpc->findvalue('dxp:tableId', $node);
    $self->{title}    = $xpc->findvalue('atom:title',  $node);

    return bless($self, $package);
}

1;



=pod

=head1 NAME

Net::Google::Analytics::AccountFeedEntry - Google Analytics API account feed entry

=head1 VERSION

version 0.11003

=head1 DESCRIPTION

This package implements account feed entries of the Google Analytics Data
Export API.

=head1 ATTRIBUTES

=head2 account_id

=head2 account_name

=head2 profile_id

=head2 web_property_id

=head2 currency

=head2 timezone

=head2 table_id

=head2 title

=head1 AUTHOR

Nick Wellnhofer <wellnhofer@aevum.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Nick Wellnhofer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


