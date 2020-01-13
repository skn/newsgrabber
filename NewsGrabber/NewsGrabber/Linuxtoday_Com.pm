package NewsGrabber::Linuxtoday_Com;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Linuxtoday_Com';  	# The local file where the headlines are stored- a '.out' is automatically added to this
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Linuxtoday_Com_print_news
{
  shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;

  $get->update_local_file('http://linuxtoday.com/backend/lthead.txt',$update_interval,$localfile);
  
  #Open the local file and print the headlines
  
  my $document="";
  #Open the local file and print the headlines
    $localfile=$localfile.'.out';
  open (LOCALFILE,"<$localfile");
  flock(LOCALFILE,2);
  <LOCALFILE>;<LOCALFILE>;<LOCALFILE>;<LOCALFILE>;
  while(<LOCALFILE>)
  {
    $document=$document.$_;
  }
  flock(LOCALFILE,8);
  close(LOCALFILE);
  
  my @document = split /\n/, $document;
  $document =~ s/&&/ / ;
  @document = split /&&/, $document ;

  for (my $counter1 =0; $counter1<$#document+1;$counter1=$counter1+1)
  {
    print "\n";
    ( my @news_array ) = split /\n/, $document[$counter1] ;
    print "<a href=\"$news_array[2]\">\n<big>$news_array[1]</big></a><br>\n";
    print "At: $news_array[3] <br>\n";
    print "<BR>\n";
  }

}

1;
