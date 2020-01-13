package NewsGrabber;

#use 'strict' ALWAYS
use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);
use NewsGrabber_Getbackend;

require Exporter;
require AutoLoader;
use XML::Parser;

@ISA = qw(Exporter AutoLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# Export the three funtions implemented by this module
 
@EXPORT = qw();
$VERSION = '1.0.31';

##################################################################################
# Some variable initilisations                                                   #
################################################################################## 
# $html_template_path should point to the path which contains the HTML templates #
# for header, title and footer. The path should be in reference to the           #
# actual perl script that uses the NewsGrabber module and NOT the module itself. #
##################################################################################
my $html_template_path=".";
#my $query=new CGI;

# Preloaded methods go here.

# Constructor 
sub new 
{
   my $type ={};
   bless $type;
   return $type;
}

####################################################################################
# The exported funtion that print the HTML header.                                 #
#                                                                                  #
# 1 parameter is passed to this function                                           #
# Parameter 1 is $html_title, the title of the HTML page generated                 # 
#                                                                                  #
# The template used is given by the path assigned to the $html_template_path       #
# and the file name is header.template                                             #
#################################################################################### 
sub print_header
{
  shift;
  my $html_title=shift;
  my $html_header='';
  print "Content-type: text/html\n\n"; 
  my $header_file=$html_template_path."/header.template";
  open (HEADERFILE,"<$header_file") ||die "Cannot find header template file";
  flock(HEADERFILE,2);
  while(<HEADERFILE>)
  {
      #print $_;
      $html_header=$html_header.$_;
  }
  
  $html_header =~ s/HTMLTITLE/$html_title/g;
  print $html_header;
  flock(HEADERFILE,8);
  close(HEADERFILE);
}

###########################################################################################
# Exported function that prints the title for a specific site headlines                   #
#                                                                                         #
# 3 parameters are passed to it.                                                          #
# Parameter 1, stored in $site_name is the name of the site (What else !)                 #
# Parameter 2, stored in $file_desc is the description of the news grabbed, usually "News"#
# Parameter 3, stored in $site_url is the URL of the site whose news is being printed     #
#                                                                                         #
# Template used is stored in 'title.template' in the directory pointed by                 #
# $html_template_path                                                                     #
###########################################################################################

sub print_title
{
  shift;
  my $site_name=shift;
  my $file_desc=shift;
  my $site_url=shift;
  
  my $title_file=$html_template_path."/title.template";
  my $title="";
  open (TITLEFILE,"<$title_file") ||die "Cannot find title template file";
  flock(TITLEFILE,2);
  while(<TITLEFILE>)
  {
    $title=$title.$_;
  }
  flock(TITLEFILE,8);
  close(TITLEFILE);
  $title =~ s/SITEURL/$site_url/g;
  $title =~ s/SITENAME/$site_name/g;
  $title =~ s/FILEDESC/$file_desc/g;
  print $title;
  flock(TITLEFILE,8);
  close(TITLEFILE);
}

 
########################################################################
# Function that prints the cleanup part of the title.                  #
# This will be the best place to close all those tables that may have  #
# been opened by the print_title function.                             #
#                                                                      #
# The template stored in "title_end.template" in the directory pointed #
# by $html_template_path is used                                       #
########################################################################

sub print_title_end
{
  my $title_end_file=$html_template_path."/title_end.template";
  open (TITLEENDFILE,"<$title_end_file") ||die "Cannot find Title End template file";
  flock(TITLEENDFILE,2);
  while(<TITLEENDFILE>)
  {
    print $_;
  }
  flock(TITLEENDFILE,8);
  close(TITLEENDFILE);
}


########################################################################
# Exported function that prints the footer part of the HTML            #
# The template stored in "footer.template" in the directory pointed by #
# $html_template_path is used                                          #
########################################################################
sub print_footer
{
  my $footer_file=$html_template_path."/footer.template";
  open (FOOTERFILE,"<$footer_file") ||die "Cannot find footer template file";
  flock(FOOTERFILE,2);
  while(<FOOTERFILE>)
  {
    print $_;
  }
  flock(FOOTERFILE,8);
  close(FOOTERFILE);
}


# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

NewsGrabber - Perl extension for grabbing news from different sites.

=head1 SYNOPSIS

  use NewsGrabber;

=head1 DESCRIPTION

This perl module is used for grabbing news/announcements from 
sites like Slashdot.Org, Freshmeat.Net, GeekNews.Org and so on.


=head1 AUTHOR

Srijith.K (srijith@srijith.net)

=head1 SEE ALSO

perl(1) 
XML::Parser(3).

=cut
