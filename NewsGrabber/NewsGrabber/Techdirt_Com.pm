package NewsGrabber::Techdirt_Com;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Techdirt_Com';  	# The local file where the headlines are stored - a '.out' is automatically added to this
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Techdirt_Com_print_news
{
	shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;

  $get->update_local_file('http://www.techdirt.com/ultramode.txt',$update_interval,$localfile);
  
  #Open the local file and print the headlines
  
  my $document="";
  #Open the local file and print the headlines
  $localfile=$localfile.'.out';
  open (LOCALFILE,"<$localfile");
  flock(LOCALFILE,2);
  <LOCALFILE>;<LOCALFILE>;
  while(<LOCALFILE>)
  {
    $document=$document.$_;
  }
  flock(LOCALFILE,8);
  close(LOCALFILE);
  
  my @document = split /\n/, $document;
  $document =~ s/%%/ / ;
  @document = split /%%/, $document ;

  for (my $counter1 =0; $counter1<$#document;$counter1=$counter1+1)
  {
    print "\n";
    ( my @news_array ) = split /\n/, $document[$counter1] ;
    print "<a href=\"$news_array[2]\">\n<big>$news_array[1]</big></a><br>\n";
    print "Category : $news_array[6]<br>\n";
    print "At: $news_array[3] <br>\n";
    print "Author : $news_array[4]<br>\n";
    print "Image: <img src=\"$news_array[5]$news_array[7]\"><br>\n";

    print "<BR>";
  }

}

1;
