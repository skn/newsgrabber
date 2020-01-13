package NewsGrabber::Cmptr_Com;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Cmptr_Com';  	# The local file where the headlines are stored
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Cmptr_Com_print_news
{
  shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;
  $get->update_local_file('http://www.cmptr.com/dump/headline.txt',$update_interval,$localfile);
  
  #Open the local file and print the headlines
  $localfile=$localfile.'.out';
  open (LOCALFILE,"<$localfile");
  flock(LOCALFILE,2);
  while(<LOCALFILE>)
  {
    print $_;
  }
  flock(LOCALFILE,8);
  close(LOCALFILE);
}

1;
