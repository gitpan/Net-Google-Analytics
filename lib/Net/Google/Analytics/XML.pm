package Net::Google::Analytics::XML;
our $VERSION = '0.10002';
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

