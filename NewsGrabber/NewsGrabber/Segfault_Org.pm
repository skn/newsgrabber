package NewsGrabber::Segfault_Org;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Segfault_Org';  	# The local file where the headlines are stored  - a '.out' is automatically added to this
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
my $print_email=1;                      # Should print description of each software ?? 1=Yes, 0=No
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Segfault_Org_print_news
{
	 shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;

$get->update_local_file('http://segfault.org/stories.txt',$update_interval,$localfile);
  #Open the local file and print the headlines
    $localfile=$localfile.'.out';
  my $document="";
  open (LOCALFILE,"<$localfile");
  flock(LOCALFILE,2);
  while(<LOCALFILE>)
  {
    $document=$document.$_;
  }
  flock(LOCALFILE,8);
  close(LOCALFILE);
  
  my @document = split /\n/, $document;
  $document =~ s/%%/ / ;
  @document = split /%%/, $document ;

  for (my $counter1 =1; $counter1<$#document;$counter1=$counter1+1)
  {
    print "\n";
    ( my @news_array ) = split /\n/, $document[$counter1] ;
    print "<a href=\"$news_array[2]\">\n$news_array[1]</a><br>\n";
    print "Type : $news_array[6]<br>\n";
    print "On: $news_array[3] <br>\n";
    print "Author : $news_array[4]";

    if($print_email)
    {
      print ",&nbsp;$news_array[5]";
    }
    print "<BR>\n<BR>";
  }

}

1;
