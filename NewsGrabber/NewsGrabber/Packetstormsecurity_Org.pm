package NewsGrabber::Packetstormsecurity_Org;

use strict;
use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);
@EXPORT=qw();

######################## Some initilisation needed for your comfort #################
my $localfile = 'Packetstormsecurity_Org';  	# The local file where the headlines are stored- a '.out' is automatically added to this
my $update_interval=30;          	# The interval in minutes at which the file is fetched fresh from server
my $number_chars=100;			# Number of characters of the description to be printed 
my $number_files=10;			# Details of latest how many files to be printed
my $trail='...';			# The trailing style after the shortdescription

######################################################################################
sub new
{
    my $self={};
    bless $self;
    return $self;
}

sub Packetstormsecurity_Org_print_news
{
 shift;
  
  # In case user passed alternate values for $update_interval, use it.
  
  my (%ALT)=@_;
  foreach (keys(%ALT)) {
    if($_ eq 'age') { $update_interval=$ALT{$_}};
  }

  my $get= new NewsGrabber_Getbackend;

  $get->update_local_file('http://www.packetstormsecurity.com/whatsnew20.html',$update_interval,$localfile);
  #Open the local file and print the headlines
    $localfile=$localfile.'.out';
  open (LOCALFILE,"<$localfile");
  flock(LOCALFILE,2);
  my $document="";
  #my $i=0;
  while(<LOCALFILE>)
  {
      $document=$document.$_;
  }
  flock(LOCALFILE,8);
  close(LOCALFILE);
  
  my @document = split /\n/, $document;
  
  for (my $i=0;$i <= $#document;$i++) {
     my $line=$document[$i];
        if($line =~ m/<!--started-->/){
	   for (my $a=1;$a<$number_files+1;$a++) {
              $line=$document[$i+$a];
              $line =~ s/<tr bgcolor=#CCCCCC><td class=fl width=56%>//g;
              (my $temp,$line) = split(/<a class=fl href=/,$line);
              ($temp,$line) = split(/<td colspan=3 class=fd>/,$line);
              (my $link,$temp) = split(/>/,$temp);
              ($temp,my $one)   = split(/<\/a/,$temp);
              my $name=$temp;
              my $trunc_line=substr($line,0,$number_chars);
              print "<a href=\"http://www.packetstormsecurity.org$link\">$name</a> $trunc_line $trail\n";
	      print "<BR>\n";
           }
        }  
   }




}

1;
