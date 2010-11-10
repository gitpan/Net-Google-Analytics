
use strict;
use warnings;

BEGIN { require 5.008; }

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Simple interface to the Google Analytics Data Export API',
  'AUTHOR' => 'Nick Wellnhofer <wellnhofer@aevum.de>',
  'BUILD_REQUIRES' => {},
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Net-Google-Analytics',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Net::Google::Analytics',
  'PREREQ_PM' => {
    'Class::Accessor' => '0',
    'LWP::UserAgent' => '0',
    'URI' => '0',
    'XML::LibXML' => '0',
    'XML::LibXML::XPathContext' => '0'
  },
  'VERSION' => '0.11002',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



