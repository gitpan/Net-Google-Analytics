package Net::Google::Analytics::AccountFeedEntry;
our $VERSION = '0.09999_01';
use strict;

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
    table_id
));

sub _parse {
    my ($package, $node) = @_;

    my $self = {};
    my $xpc = $package->_xpc;

    for(my $i=0; $i<@property_map; $i+=2) {
        my $from = $property_map[$i+1];
        my $to   = $property_map[$i];

        $self->{$to} = $xpc->findvalue(
            "dxp:property[\@name='ga:$from']/\@value",
            $node
        );
    }

    $self->{table_id} = $node->findvalue('dxp:tableId');

    return bless($self, $package);
}

1;

__END__

=head1 NAME

Net::Google::Analytics::AccountFeedEntry - Google Analytics API account feed
entry

=head1 DESCRIPTION

This package implements account feed entries of the Google Analytics Data
Export API.

=head1 ACCESSORS

=head2 account_id

=head2 account_name

=head2 profile_id

=head2 web_property_id

=head2 currency

=head2 timezone

=head2 table_id

=cut

