package NewsGrabber::Fileforum_Betanews_Com;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Fileforum_Betanews_Com';  	# The local file where the headlines are stored - a '.out' is automatically added to this
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Fileforum_Betanews_Com_print_news
{ 

 shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;
  $get->update_local_file('http://fileforum.betanews.com/backend.php3',$update_interval,$localfile);

  #Open the local file and print the headlines
  my $file_name='';
  my $file_version='';
  my $file_date='';
  my $file_desc='';
  my $file_url='';
  $localfile=$localfile.'.out';
  open (LOCALFILE,"<$localfile");
  flock(LOCALFILE,2);
  while(<LOCALFILE>)
  {
    $file_name=$_;
    $file_version=<LOCALFILE>;
    $file_date=<LOCALFILE>;
    $file_desc=<LOCALFILE>;
    $file_url=<LOCALFILE>;    
    
    print "<a href=\"$file_url\">$file_name</a> - Version $file_version<br>\n";
    print "At $file_date<br>\n";
    print $file_desc;
 
    print "<BR><br>\n";
  }
  flock(LOCALFILE,8);
  close(LOCALFILE);
}

1;
