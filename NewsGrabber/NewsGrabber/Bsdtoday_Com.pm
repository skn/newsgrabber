package NewsGrabber::Bsdtoday_Com;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Bsdtoday_Com';  	# The local file where the headlines are stored- a '.out' is automatically added to this
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Bsdtoday_Com_print_news
{
    shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;
  $get->update_local_file('http://www.bsdtoday.com/backend/btrecentnews.txt',$update_interval,$localfile);

  #Open the local file and print the headlines
  my $counter=0;
  my $headline="";
  my $date="";
  my $link="";
  $localfile=$localfile.'.out';
  open (LOCALFILE,"<$localfile");
  flock(LOCALFILE,2);
  
  while(<LOCALFILE>)
  {
    $headline = $_;
    $date=<LOCALFILE>; 
    $link = <LOCALFILE>;
    
    $counter=$counter+1;
    print "<FONT COLOR=red>$counter</FONT>&nbsp;<a href=\"$link\">$headline</a><BR>\n";
    print "$date<BR><BR>\n\n";
  }
  flock(LOCALFILE,8);
  close(LOCALFILE);
}

1;
