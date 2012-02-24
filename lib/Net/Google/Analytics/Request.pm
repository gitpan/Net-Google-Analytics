package Net::Google::Analytics::Request;
{
  $Net::Google::Analytics::Request::VERSION = '2.99_01';
}
use strict;

# ABSTRACT: Google Analytics API request

use Class::XSAccessor
    accessors => [ qw(
        ids
        start_date end_date
        metrics dimensions
        sort
        filters
        segment
        start_index max_results
        fields
        pretty_print
        user_ip quota_user
    ) ],
    constructor => 'new';

my @param_map = (
    ids          => 'ids',
    start_date   => 'start-date',
    end_date     => 'end-date',
    metrics      => 'metrics',
    dimensions   => 'dimensions',
    sort         => 'sort',
    filters      => 'filters',
    segment      => 'segment',
    fields       => 'fields',
    pretty_print => 'prettyPrint',
    user_ip      => 'userIp',
    quota_user   => 'quotaUser',
);

sub _params {
    my $self = shift;

    for my $name (qw(ids metrics start_date end_date)) {
        my $value = $self->{$name};
        die("parameter $name is empty")
            if !defined($value) || $value eq '';
    }

    my @params;

    for (my $i=0; $i<@param_map; $i+=2) {
        my $from = $param_map[$i];
        my $to   = $param_map[$i+1];

        my $value = $self->{$from};
        push(@params, $to => $value) if defined($value);
    }

    return @params;
}

1;



=pod

=head1 NAME

Net::Google::Analytics::Request - Google Analytics API request

=head1 VERSION

version 2.99_01

=head1 DESCRIPTION

Request class for L<Net::Google::Analytics> web service.

=head1 ACCESSORS

=head2 ids

=head2 start_date

=head2 end_date

=head2 metrics

=head2 dimensions

=head2 sort

=head2 filters

=head2 segment

=head2 start_index

=head2 max_results

=head2 fields

=head2 pretty_print

=head2 user_ip

=head2 quota_user

 $req->ids('ga:...');
 $req->dimensions('ga:...');

See the API reference for a description of the request parameters. The
provided parameter values must not be URL encoded.

=head1 AUTHOR

Nick Wellnhofer <wellnhofer@aevum.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Nick Wellnhofer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


