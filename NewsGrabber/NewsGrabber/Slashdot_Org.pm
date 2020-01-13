package NewsGrabber::Slashdot_Org;

#################################################################
# Perl module that fetches the backend news from Slashdot.Org   								#
# Uses NewsGrabber_Getbackend to do the actuall fetching        								#
#################################################################

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw(); 

######################## Some initilisation needed for your comfort #################
my $localfile = 'Slashdot_Org';     # The local file where the headlines are stored - a '.out' is automatically added to this
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
 
my $title="";
my $url="";
my $time="";
my $author="";
my $department="";
my $topic="";
my $section="";
my $comments="";
my $image="";
my $flag=0;
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Slashdot_Org_print_news
{
	shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;

  # Call the function exported by NewsGrabber_Getbackend
  # Three parameters are passed
  # The URL of the remote backend file, the update interval and the site specifics 
  $get->update_local_file('http://www.slashdot.org/slashdot.xml',$update_interval,$localfile);

  my $parser = new XML::Parser(ErrorContext => 2);
  $parser->setHandlers(Start => \&start_handler,
                     End   => \&end_handler,
                     Char  => \&char_handler);

  $localfile=$localfile.'.out';
  eval {$parser->parsefile($localfile)};
  warn 'Malformed XML' if $@;

}

# ----------------------------------
# The handlers for the XML Parser.
# ----------------------------------

sub start_handler
{
    my $expat = shift; my $element = shift;

    # element is the name of the tag
   if($element eq 'title')
   {  $title="";$url="";$time="";$author="";
      $department="";$topic="";$comments="";
      $section="";$image="";
      $flag=1;
   } 

   if($element eq 'url')
   { $flag=2;}
   
   if($element eq 'time')
   { $flag=3;}

   if($element eq 'author')
   { $flag=4;}
  
   if($element eq 'department')
   { $flag=5;}

   if($element eq 'topic')
   { $flag=6;}

   if($element eq 'comments')
   { $flag=7;}

   if($element eq 'section')
   { $flag=8;}

   if($element eq 'image')
   { $flag=9;}
	
    # Handle the attributes
    while (@_) {
        my $att = shift;
        my $val = shift;
    }

}

sub end_handler
{
   my $expat = shift; my $element = shift;
   
   if($flag=9 && $title && $url && $time && $author && $department && $topic && $comments && $section && $image) 
   {
       print "Title: <a href=\"$url\">$title</a><BR>\n";
       print "Time: $time<br>\n";
       print "Author: $author <br>\n";
       print "Department: $department<br>\n";
       print "Topic: $topic<br>\n";
       print "Comments: $comments<br>\n";
       print "Section: $section<br>\n";
       print "Image: <img src=\"http://images.slashdot.org/topics/$image\"<br><br><br>\n";

       $title="";$url="";$time="";$author="";$department="";$topic="";$comments="";$section="";$image="";
   }
}


sub char_handler
{
   my ($p, $data) = @_;
   if($data) {
     if($flag==1)
       {$title=$title.$data;}
     if($flag==2)
       {$url=$url.$data;}
     if($flag==3)
       {$time=$time.$data;}
     if($flag==4)
       {$author=$author.$data;}
     if($flag==5)
       {$department=$department.$data;}
      if($flag==6)
       {$topic=$topic.$data;}
      if($flag==7)
       {$comments=$comments.$data;}
      if($flag==8)
       {$section=$section.$data;}
      if($flag==9)
       {$image=$image.$data;}
   }
}

1;








