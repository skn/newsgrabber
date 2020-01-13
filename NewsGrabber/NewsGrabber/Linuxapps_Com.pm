package NewsGrabber::Linuxapps_Com;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Linuxapps_Com';  	# The local file where the headlines are stored- a '.out' is automatically added to this
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Linuxapps_Com_print_news
{
  shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;

  $get->update_local_file('http://www.linuxapps.com/backend/basic.txt',$update_interval,$localfile);

  #Open the local file and print the headlines
  my $counter=0;
  my $news="";
  my $date="";
  my $story_url="";
  
  $localfile=$localfile.'.out';
  open (LOCALFILE,"<$localfile");
  flock(LOCALFILE,2);
  while(<LOCALFILE>)
  {
    $counter=$counter+1;
    $news=$_;
    chop $news;
    $date=<LOCALFILE>;   
    $story_url=<LOCALFILE>;
    
    print "<FONT COLOR=red>$counter</FONT> &nbsp;";
    print "<a href=\"$story_url\">$news</a> <BR>";
    print "\nDate: $date<BR><BR>";
    
  }
  flock(LOCALFILE,8);
  close(LOCALFILE);
}


1;
