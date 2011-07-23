package Net::Google::Analytics::XML;
BEGIN {
  $Net::Google::Analytics::XML::VERSION = '0.11003';
}
use strict;

use XML::LibXML;
use XML::LibXML::XPathContext;

my $parser = XML::LibXML->new();
my $xpc = XML::LibXML::XPathContext->new();
$xpc->registerNs(atom       => 'http://www.w3.org/2005/Atom');
$xpc->registerNs(dxp        => 'http://schemas.google.com/analytics/2009');
$xpc->registerNs(openSearch => 'http://a9.com/-/spec/opensearch/1.1/');

sub _parser {
    return $parser;
}

sub _xpc {
    return $xpc;
}

1;


__END__
=pod

=head1 NAME

Net::Google::Analytics::XML

=head1 VERSION

version 0.11003

=head1 AUTHOR

Nick Wellnhofer <wellnhofer@aevum.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Nick Wellnhofer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

