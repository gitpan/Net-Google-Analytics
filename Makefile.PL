
use strict;
use warnings;

 BEGIN { require 5.008; } 

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Net::Google::Analytics',
                       'DISTNAME' => 'Net-Google-Analytics',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Nick Wellnhofer <wellnhofer@aevum.de>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'Simple interface to the Google Analytics Data Export API',
                       'EXE_FILES' => [],
                       'VERSION' => '0.11000',
                       'PREREQ_PM' => {
                                        'XML::LibXML::XPathContext' => '0',
                                        'LWP::UserAgent' => '0',
                                        'URI' => '0',
                                        'XML::LibXML' => '0',
                                        'Class::Accessor' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{BUILD_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.56) };

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



