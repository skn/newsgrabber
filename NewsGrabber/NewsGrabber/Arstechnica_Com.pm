package NewsGrabber::Arstechnica_Com;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw ();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Arstechnica_Com';  	# The local file where the headlines are stored - a '.out' is automatically added to this
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
my $headline="";
my $link="";
my $flag=0;
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Arstechnica_Com_print_news
{
  shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;
  $get->update_local_file('http://arstechnica.com/etc/rdf/ars.rdf',$update_interval,$localfile);

  my $parser = new XML::Parser(ErrorContext => 2);
  $parser->setHandlers(Start => \&start_handler,
                     End   => \&end_handler,
                     Char  => \&char_handler);
  $localfile=$localfile.'.out';
  eval {$parser->parsefile($localfile)};
  warn 'Malformed XML code' if $@;
}


# ----------------------------------
# The handlers for the XML Parser.
# ----------------------------------

sub start_handler
{
    my $expat = shift; my $element = shift;

    # element is the name of the tag
   if($element eq 'title')
   { $headline="";$link="";$flag=1; } 
   if($element eq 'link')
   { $flag=2;}
	
    # Handle the attributes
    while (@_) {
        my $att = shift;
        my $val = shift;
    }

}

sub end_handler
{
   my $expat = shift; my $element = shift;
   
   if($flag=2 && $link && $headline) 
   {
     if($headline!~ /Ars Technica/)
     {
       print "<a href=\"$link\" target=_blank>$headline</a><BR>\n";
       $headline="";$link="";
     }
   }
}


sub char_handler
{
   my ($p, $data) = @_;
   if($data) {
     if($flag==1)
       {$headline=$headline.$data;}
     if($flag==2)
       {$link=$link.$data;}
   }
}

1;
