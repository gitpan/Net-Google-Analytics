
use strict;
use warnings;

 BEGIN { require 5.008; } 

use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Net::Google::Analytics',
                       'DISTNAME' => 'Net-Google-Analytics',
                       'AUTHOR' => 'Nick Wellnhofer <wellnhofer@aevum.de>',
                       'ABSTRACT' => 'Simple interface to the Google Analytics Data Export API',
                       'EXE_FILES' => [],
                       'VERSION' => '0.10001',
                       'LICENSE' => 'perl',
                       'PREREQ_PM' => {
                                        'URI' => '0',
                                        'LWP::UserAgent' => '0',
                                        'ExtUtils::MakeMaker' => '6.11',
                                        'XML::LibXML' => '0',
                                        'Class::Accessor' => '0'
                                      }
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



