package NewsGrabber::Freshmeat_Net;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Freshmeat_Net';  # The local file where the headlines are stored -  a '.out' is automatically added to this
my $update_interval=30;          	  # The interval in minutes at which the file is fetched fresh from server
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

# Exported function
sub Freshmeat_Net_print_news
{
  shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;
  $get->update_local_file('http://www.freshmeat.net/backend/recentnews.txt',$update_interval,$localfile);

  #Open the local file and print the headlines
    $localfile=$localfile.'.out';
  open (LOCALFILE,"<$localfile");
  flock(LOCALFILE,2);

  my $prj_name='';
  my $prj_date='';
  my $prj_url='';	
  for (my $counter1 =1; $counter1<11;$counter1=$counter1+1)
  {
    print "\n";
    $prj_name=<LOCALFILE>;
    $prj_date=<LOCALFILE>;
    $prj_url=<LOCALFILE>;
    print "<a href=\"$prj_url\">$prj_name</a> at $prj_date\n";
    print "<BR>";
  }
  flock(LOCALFILE,8);
  close(LOCALFILE);
}


1;
