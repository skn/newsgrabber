package NewsGrabber::Moreover_Com;

use strict;
use vars qw(@ISA @EXPORT);
require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = '';  		# The local file where the headlines are stored
								# Got by concatinating passed in variable with 'Moreover_Com_*.out'
my $update_interval=30;          # The interval in minutes at which the file is fetched fresh from server
my $headline="";
my $link="";
my $desc='';
my $flag=0;
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}


sub Moreover_Com_print_news
{

  shift;
  my $feed_url='';
  my $feed_file_number='';
   # In case user passed alternate values for $update_interval, use it.
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
    if($_ eq 'url') { $feed_url=$ALT{$_}};
    if($_ eq 'number') { $feed_file_number=$ALT{$_}};
  }

  my $file_name_temp="Moreover_Com_".$feed_file_number; 
  my $get= new NewsGrabber_Getbackend;
  $get->update_local_file($feed_url,$update_interval,$file_name_temp);

  my $parser = new XML::Parser(ErrorContext => 2);
  $parser->setHandlers(Start => \&start_handler,
                     End   => \&end_handler,
                     Char  => \&char_handler);

  $localfile=$file_name_temp.".out";
  eval{$parser->parsefile($localfile)};
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
   { $headline="";$link="";$desc='';$flag=1; } 
   if($element eq 'link')
   { $flag=2;}
   if ($element eq 'description')
   {$flag=3;}
	
    # Handle the attributes
    while (@_) {
        my $att = shift;
        my $val = shift;
    }

}

sub end_handler
{
   my $expat = shift; my $element = shift;
   
   if($flag=3 && $link && $headline && $desc) 
   {
     if($headline!~ /moreover.../ && $link!~ /http:\/\/www.moreover.com/)
     {
       print "<a href=\"$link\">$headline</a><BR>$desc<BR><BR>\n";
       $headline="";$link="";$desc='';
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
     if($flag==3)
       {$desc=$desc.$data;}
   }
}

1;
