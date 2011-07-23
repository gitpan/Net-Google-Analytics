package Net::Google::Analytics::Dimension;
BEGIN {
  $Net::Google::Analytics::Dimension::VERSION = '0.11003';
}
use strict;

# ABSTRACT: Google Analytics API dimension

use base qw(Class::Accessor);

__PACKAGE__->mk_accessors(qw(name value));

sub _parse {
    my ($package, $node) = @_;

    my $self = {
        name  => $node->getAttribute('name'),
        value => $node->getAttribute('value'),
    };

    return bless($self, $package);
}

1;



=pod

=head1 NAME

Net::Google::Analytics::Dimension - Google Analytics API dimension

=head1 VERSION

version 0.11003

=head1 DESCRIPTION

This package implements dimension data of the Google Analytics Data Export
API.

See
L<http://code.google.com/apis/analytics/docs/gdata/gdataReferenceDimensionsMetrics.html#dimensions>
for a reference.

=head1 ATTRIBUTES

=head2 name

The name of the dimension.

=head2 value

The value of the dimension.

=head1 AUTHOR

Nick Wellnhofer <wellnhofer@aevum.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Nick Wellnhofer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


