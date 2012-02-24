package Net::Google::Analytics::Response;
{
  $Net::Google::Analytics::Response::VERSION = '2.99_01';
}
use strict;

# ABSTRACT: Google Analytics API response

use Class::XSAccessor
    accessors => [ qw(
        is_success code message content
        total_results start_index items_per_page
        _column_headers rows _totals
    ) ],
    constructor => 'new';

sub error_message {
    my $self = shift;

    return join(' ', $self->code,  $self->message, $self->content);
}

sub _parse_json {
    my ($self, $json) = @_;

    $self->items_per_page($json->{itemsPerPage});
    $self->total_results($json->{totalResults});

    my $json_totals = $json->{totalsForAllResults};
    my %totals;

    while (my ($json_name, $total) = each(%$json_totals)) {
        my $column_name = _parse_column_name($json_name);
        $totals{$column_name} = $total;
    }

    $self->_totals(\%totals);

    my @column_headers;

    for my $column_header (@{ $json->{columnHeaders} }) {
        push(@column_headers, {
            name        => _parse_column_name($column_header->{name}),
            column_type => $column_header->{columnType},
            data_type   => $column_header->{dataType},
        });
    }

    $self->_column_headers(\@column_headers);

    my $class = Net::Google::Analytics::Row->_gen_class(\@column_headers);

    my @rows = map { $class->new($_) } @{ $json->{rows} };
    $self->rows(\@rows);
}

sub _parse_column_name {
    my $name = shift;

    my ($res) = $name =~ /^ga:(\w{1,64})\z/
        or die("invalid column name: $name");

    # convert camel case
    $res =~ s/[A-Z]/'_' . lc($&)/ge;

    return $res;
}

sub metrics {
    my $self = shift;

    return $self->_columns('METRIC');
}

sub dimensions {
    my $self = shift;

    return $self->_columns('DIMENSION');
}

sub totals {
    my ($self, $metric) = @_;

    return $self->_totals->{$metric};
}

sub _columns {
    my ($self, $type) = @_;

    my $column_headers = $self->_column_headers;
    my @results;

    for my $column_header (@$column_headers) {
        if ($column_header->{column_type} eq $type) {
            push(@results, $column_header->{name});
        }
    }

    return @results;
}

sub project {
    my ($self, $proj_dim_names, $projection) = @_;

    my (@metric_indices, @proj_column_headers);
    my $column_headers = $self->_column_headers;

    for (my $i = 0; $i < @$column_headers; ++$i) {
        my $column_header = $column_headers->[$i];

        if ($column_header->{column_type} eq 'METRIC') {
            push(@metric_indices, $i);
            push(@proj_column_headers, { %$column_header });
        }
    }

    for my $name (@$proj_dim_names) {
        push(@proj_column_headers, {
            name        => $name,
            column_type => 'DIMENSION',
        });
    }

    my $class = Net::Google::Analytics::Row->_gen_class(\@proj_column_headers);

    # Projected rows are collected in hash %proj_rows. The keys of the hash
    # are the the projected dimension values joined with zero bytes.

    my %proj_rows;

    for my $row (@{ $self->rows }) {
        my @proj_dim_values = $projection->($row);
        my $key = join("\0", @proj_dim_values);

        my $proj_row = $proj_rows{$key};

        if (!$proj_row) {
            my @proj_metric_values = map { $row->[$_] } @metric_indices;
            $proj_rows{$key} = $class->new(
                [ @proj_metric_values, @proj_dim_values ],
            );
        }
        else {
            for (my $i = 0; $i < @metric_indices; ++$i) {
                my $mi = $metric_indices[$i];
                $proj_row->[$i] += $row->[$mi];
            }
        }
    }

    $self->rows([ values(%proj_rows) ]);
}

1;



=pod

=head1 NAME

Net::Google::Analytics::Response - Google Analytics API response

=head1 VERSION

version 2.99_01

=head1 DESCRIPTION

Response class for L<Net::Google::Analytics> web service.

=head1 ACCESSORS

=head2 is_success

True for successful requests, false in case of an error

=head2 code

The HTTP status code

=head2 message

The HTTP status message

=head2 error_message

The full error message

=head2 total_results

The total number of results for the query, regardless of the number of
results in the response.

=head2 start_index

The 1-based start index of the entries.

=head2 items_per_page

The number of rows.

=head2 rows

An arrayref of result rows.

=head2 dimensions

An array of all dimension names without the 'ga:' prefix and converted to
lower case with underscores.

=head2 metrics

An array of all metric names without the 'ga:' prefix and converted to
lower case with underscores.

=head1 METHODS

=head2 totals

    my $total = $res->totals($metric);

Returns the total of all results for a metric. $metric is a metric name
without the 'ga:' prefix and converted to lower case with underscores.

=head2 project

    $res->project(\@proj_dim_names, \&projection);

Projects the dimension values of every entry to a set of new dimension values
using subroutine reference \&projection. The metrics of entries that are
mapped to the same dimension values are summed up.

Argument \@proj_dim_names is an arrayref containing the names of the
new dimensions.

The projection subroutine takes as single argument a
L<Net::Google::Analytics::Row> object and must return an array of dimension
values.

The following example maps a single dimension of type ga:pagePath to
categories.

    $res->project([ 'category' ], sub {
        my $row = shift;

        my $page_path = $row->get_pagePath;

        return ('flowers') if $page_path =~ m{^/(tulips|roses)};
        return ('fruit')   if $page_path =~ m{^/(apples|oranges)};

        return ('other');
    });

=head1 AUTHOR

Nick Wellnhofer <wellnhofer@aevum.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Nick Wellnhofer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

