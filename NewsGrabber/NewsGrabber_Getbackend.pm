package NewsGrabber_Getbackend;

##########################################################################
# Perl module that actually fetches the backend files from servers/sites #
##########################################################################


# use 'strict' always
use strict;

# Modules used for accessing the internet. 
use LWP::UserAgent;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);


require Exporter;
require AutoLoader;

@ISA = qw(Exporter AutoLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

@EXPORT=qw();
$VERSION = '1.0.31';

# Set $proxy_server to the proxy server if needed
# If you don't know what a proxy server is, you better leave this alone
# eg: $proxy_server='http://proxy.mysite.com:8080';
my $proxy_server='';

# Set $proxy_username and $proxy_passwd if you need to be aunthenticated
# to be able to access the proxy. 
# Support for Basic Autherisation only.
my $proxy_username='';
my $proxy_passwd='';

# $update_file points to the file that stores the age of each localfile
# This file is with reference to the actuall calling Perl script and not
# this Perl module
my $updatefile='update.txt';

# Get the current time
my $current_time=0;

my %site_hash=();
my $parameter_name='';
my $localfile='';
my $url='';
my $site_last_update=0;
my $update_interval=0;

sub new 
{
    my $self={};
    %site_hash=();
    $parameter_name='';
    $localfile='';
    $url='';
    $site_last_update=0;
    $update_interval=0;
    bless $self;
    return $self;
}


##################################################################################
# Preloaded methods go here.

#####################################################################################
# Function that calls for checking of local file age, fetches new file and #
# update the age of the file                                                        #
#                                                                                   #
# Accepts 3 parameters                                                              #
# Parameter 1, stored in $url points to the URL of the remote backend file          #
# Parameter 2, stored in $update_interval is the time (in minute) after which news  #
#  file has to be fetched                                                           #
# Parameter 3, stored in $parameter_name is the name of the individual site specs   #
#####################################################################################
sub update_local_file
{
  shift;
  $url= shift;
  $update_interval=shift;
  $parameter_name=shift;

  # Form the name of the file that stores the news locally
  $localfile= $parameter_name.".out";
  

  # Call the function that actuallt checks the local file age.
  &check_localfile_age;

  if(exists($site_hash{$parameter_name}))
  {
     $site_last_update=$site_hash{$parameter_name};
  }
  else
  {
     $site_hash{$parameter_name}=0;   
  }
  my $update_interval_sec=$update_interval*60;
  my $new_update_time=$site_last_update+$update_interval_sec;

  $current_time=time;
  if($current_time>$new_update_time)
  {
    # Ok.. File is too old.. Fetch new file from server
    # and update the age of the local file
    &get_backend_file;
    &update_localfile_age;
  }
  $current_time=0;
}

#########################################
# Function to check the local file's age #
# Not exported                           #
##########################################
sub check_localfile_age
{
  open(UPDATE, $updatefile) || die "Error opening update log file!\n";
  flock(UPDATE,2);
  #populate $site_hash with site name and last update time
  while(<UPDATE>)
  {
    my($site_name,$site_update)=split(/=/,$_);
    if($site_name && $site_update)
    {
      $site_hash{$site_name}=$site_update;
    }
  } 
  flock(UPDATE,8);
  close(UPDATE);
}


####################################################################
# Function that actually gets the remote file and saves it locally #
# Not exported                                                     #
####################################################################
sub get_backend_file
{
  # The $url points to the XML/text/anyother file that stores the headlines.
  
  my $ua=new LWP::UserAgent;
  if($proxy_server)
  {
    $ua->proxy('http',$proxy_server);
  }
  my $request=new HTTP::Request('GET',$url);
  if ($proxy_username)
  {
    $request->proxy_authorization_basic($proxy_username, $proxy_passwd);
  }
  my $response=$ua->request($request);
  if(!$response->is_success)
  {
    # Trouble fetching file from server.. !!
    print "Can't get backend file $url from the server using the proxy $proxy_server.";
    # Since no fetch of feed has take place, dont update the update time with new value
    $site_hash{$parameter_name}="$site_last_update\n";
    return;
  }

  my $document=$response->content;
  my @document = split /\n/, $document;
  
  # Save into local file
  open(LOCALFILE,">$localfile") || die "Cannot open the local file for write\n";
  flock(LOCALFILE,2);
  my $line="";
  foreach $line (@document)
  {
    print LOCALFILE "$line\n";
  } 
  flock(LOCALFILE,8);
  close(LOCALFILE);
  #Since successful update has taken place, update the last_update_time with new value
  $site_hash{$parameter_name}="$current_time\n";
}

###########################################
# Function to update the local file's age #
# Not exported                            #
###########################################
sub update_localfile_age
{
  # Update the update_time and save into file
  #$site_hash{$parameter_name}="$current_time\n";

  #Write all the keys and value of the $site_hash hash to file
  open(UPDATE,">$updatefile") || die "Error opening counter file!\n";
  flock(UPDATE, 2);  # locks the file - 2 to lock, 8 to unlock

  #$update_file_content->save("UPDATE");
  my $site_name='';
  foreach $site_name(keys %site_hash)
  {
     print UPDATE "$site_name=$site_hash{$site_name}";
  }

  flock(UPDATE, 8); # unlock file
  close(UPDATE);
}


# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__

=head1 NAME

Name - NewsGrabber_Getbackend.pm

=head1 SYNOPSIS

Called internally by site modules.

=head1 DESCRIPTION

This perl module is used for the actual grabbing of news/announcemen
from remote sites. Has support for Proxy as well as Basic Proxy Authentication.
Used with NewsGrabber.pm

=head1 AUTHOR

Srijith.K (srijith@srijith.net)

=head1 SEE ALSO

perl(1)
LWP(3)

=cut
