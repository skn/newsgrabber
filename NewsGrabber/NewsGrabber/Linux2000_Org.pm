package NewsGrabber::Linux2000_Org;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Linux2000_Org';  	# The local file where the headlines are stored - a '.out' is automatically added to this
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
my $number_to_print=15;                 # The maximum number of headlines to print
my $print_descriptions=1;		# 1= Want headings to be printed,0= Don't want
my $print_poster_name=1;                # 1= Want poster's name, 0=Don't want
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Linux2000_Org_print_news
{
	shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;

  $get->update_local_file('http://www.linux-2000.org/news/newswire.txt',$update_interval,$localfile);
  #Open the local file and print the headlines
  my $counter=0;
    $localfile=$localfile.'.out';
  open (LOCALFILE,"<$localfile");
  flock(LOCALFILE,2);
  while(<LOCALFILE>) 
  {
    if ($counter<$number_to_print)
    {
      $counter=$counter+1;
      my $title=$_;
      my $post=<LOCALFILE>;
      my $url=<LOCALFILE>;
      chop ($url);
      my $description=<LOCALFILE>;
      my $blank=<LOCALFILE>;
      print "\n";
      print "<FONT COLOR=red>$counter</FONT> <a href=\"$url\">\n$title</a><br>\n";
      if($print_poster_name)
      {
        print "$post<br>\n";
      }
      if($print_descriptions)
      {
        print "$description<br><br>\n";
      }
    }
  
  }
  flock(LOCALFILE,8);
  close(LOCALFILE);
}
1;
