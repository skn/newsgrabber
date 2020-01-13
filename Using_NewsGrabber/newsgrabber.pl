#!/usr/local/bin/perl -w

# The above line should point to the location of Perl

# The next syntax should be set to point to the absolute path of
# directory that contains the NewsGrabber.pm Perl module
# eg : use lib '/home/srijith/projects/NewsGrabber';
#
# NOTE: Moreover.com feeds are implemented in a slightly different manner.
# This is because Moreover has more that 300 feeds. So a generic call 
# is implemented. Read detailed comments near the Moreover call.
#

use lib 'FILL ME!';

#You have to use NewsGrabber!
use NewsGrabber;

# Now use all those sites you want.
# Make sure you comment out those sites
# you dont want, so that they are not 
# loaded unnecessarily.

use NewsGrabber::Slashdot_Org;
use NewsGrabber::Freshmeat_Net;
use NewsGrabber::Geeknews_Net;
use NewsGrabber::Linux2000_Org;
use NewsGrabber::Techdirt_Com;
use NewsGrabber::Cmptr_Com;
use NewsGrabber::Segfault_Org;
use NewsGrabber::Icewalkers_Com;
use NewsGrabber::Mozilla_Org;
use NewsGrabber::Hotwired_Com;
use NewsGrabber::Linux_Com;
use NewsGrabber::Linuxapps_Com;
use NewsGrabber::Lwn_Net;
use NewsGrabber::Arstechnica_Com;
use NewsGrabber::Fileforum_Betanews_Com;
use NewsGrabber::Betanews_Com;
use NewsGrabber::Technotronic_Com;
use NewsGrabber::Packetstormsecurity_Org;
use NewsGrabber::Dotcomma_Org;
use NewsGrabber::Bsdtoday_Com;
use NewsGrabber::Newsforge_Net;
use NewsGrabber::Kuro5hin_Org;
use NewsGrabber::Linuxtoday_Com;
use NewsGrabber::Plastic_Com;
use NewsGrabber::Theregister_Co_Uk;
use NewsGrabber::Dotcomscoop_Com;
use NewsGrabber::Salon_Com;
use NewsGrabber::Moreover_Com;
use NewsGrabber::Cert_Org.pm;
use NewsGrabber::TWLC_Net.pm;
use NewsGrabber::Hackinthebox_Org.pm;

# Initialse the module
my $grabber=new NewsGrabber;

# Print the header HTML 
# The parameter to be passed should be the name you want for the page.
# The template used is header.template
$grabber->print_header('Headline Grabbers');

# Now for the actual feeds
# Print the Slashdo.Org title and news feed

# print_title takes in 3 parameters:-
# Parameter 1 - Name of Site
# Parameter 2 - Type of feed (eg. News,Files)
# Parameter 3 - URL of Site
# Template used is title.template
$grabber->print_title(Slashdot,News,'http://www.slashdot.org');

# Then all we need to do is to call the function to print the feeds
# So first we create the Slashdot_Org object
my $site=new NewsGrabber::Slashdot_Org;

# And then we call the function to print the news
# We can either pass the value of staleness factor in minutes 
# Or not pass anyting and thus letting it revert to the default of 30 minutes.
$site->Slashdot_Org_print_news(age=>10);

# Now print the title's closing section.
# If you had started a table or something during the call to
# print_title() call, this is the best place to close it!
# The template used is title_end.template
$grabber->print_title_end;

$grabber->print_title(Freshmeat,News,'http://www.freshmeat.net');
$site=new NewsGrabber::Freshmeat_Net;
# Here we do not pass the age parameter. So the default ot 30 minutes is assumed
# The default value is defined in each site's .pm file
$site->Freshmeat_Net_print_news();
$grabber->print_title_end;

$grabber->print_title(Geeknews,News,'http://www.geeknews.net');
$site=new NewsGrabber::Geeknews_Net;
#We can also call the print_news function without the brackets as below
$site->Geeknews_Net_print_news;
$grabber->print_title_end;

$grabber->print_title('Linux-2000',News,'http://www.linux-2000.org');
$site= new NewsGrabber::Linux2000_Org;
$site->Linux2000_Org_print_news(age=>10);
$grabber->print_title_end;

$grabber->print_title(TWLC,News,'http://www.twlc.net');
$site=new NewsGrabber::TWLC_Net;
$site->TWLC_Net_print_news(age=>30);
$grabber->print_title_end;

$grabber->print_title(Hackinthebox,News,'http://www.hackinthebox.org');      
$site=new NewsGrabber::Hackinthebox_Org;      
$site->Hackinthebox_Org_print_news(age=>30);      
$grabber->print_title_end;

$grabber->print_title(Techdirt,News,'http://www.techdirt.com');
$site=new NewsGrabber::Techdirt_Com;
$site->Techdirt_Com_print_news;
$grabber->print_title_end;

$grabber->print_title(Cmptr,News,'http://www.cmptr.com');
$site=new NewsGrabber::Cmptr_Com;
$site->Cmptr_Com_print_news;
$grabber->print_title_end;

$grabber->print_title(Segfault,News,'http://www.segfault.org');
$site=new NewsGrabber::Segfault_Org;
$site->Segfault_Org_print_news;
$grabber->print_title_end;

$grabber->print_title(Icewalkers,News,'http://www.icewalkers.com');
$site=new NewsGrabber::Icewalkers_Com;
$site->Icewalkers_Com_print_news;
$grabber->print_title_end;

$grabber->print_title(Mozilla,News,'http://www.mozilla.org');
$site=new NewsGrabber::Mozilla_Org;
$site->Mozilla_Org_print_news;
$grabber->print_title_end;

$grabber->print_title(Hotwired,News,'http://www.hotwired.com');
$site=new NewsGrabber::Hotwired_Com;
$site->Hotwired_Com_print_news;
$grabber->print_title_end;

$grabber->print_title('Linux.Com', News,'http://www.linux.com');
$site=new NewsGrabber::Linux_Com;
$site->Linux_Com_print_news;
$grabber->print_title_end;

$grabber->print_title('LinuxApps.Com',News,'http://www.linuxapps.com');
$site=new NewsGrabber::Linuxapps_Com;
$site->Linuxapps_Com_print_news;
$grabber->print_title_end;

$grabber->print_title('Lwn.Net',News,'http://www.lwn.net');
$site=new NewsGrabber::Lwn_Net;
$site->Lwn_Net_print_news;
$grabber->print_title_end;

$grabber->print_title(Arstechinca,News,'http://www.arstechinca.com');
$site=new NewsGrabber::Arstechnica_Com;
$site->Arstechnica_Com_print_news;
$grabber->print_title_end;

$grabber->print_title(CERT,News,'http://www.cert.org');
$site=new NewsGrabber::Cert_Org;
$site->Cert_Org_print_news;
$grabber->print_title_end;

$grabber->print_title('File Forum',News,'http://fileforum.betanews.com');
$site=new NewsGrabber::Fileforum_Betanews_Com;
$site->Fileforum_Betanews_Com_print_news;
$grabber->print_title_end;

$grabber->print_title(Betanews,News,'http://www.betanews.com');
$site=new NewsGrabber::Betanews_Com;
$site->Betanews_Com_print_news;
$grabber->print_title_end;

$grabber->print_title(Technotronic,News,'http://www.technotronic.com');
$site=new NewsGrabber::Technotronic_Com;
$site->Technotronic_Com_print_news;
$grabber->print_title_end;

$grabber->print_title(Packetstorm,'NewFiles','http://www.packetstormsecurity.org');
$site=new NewsGrabber::Packetstormsecurity_Org;
$site->Packetstormsecurity_Org_print_news;
$grabber->print_title_end;

$grabber->print_title(Dotcomma,'News','http://www.dotcomma.org');
$site=new NewsGrabber::Dotcomma_Org;
$site->Dotcomma_Org_print_news;
$grabber->print_title_end;

$grabber->print_title(Bsdtoday,'News','http://www.bsdtoday.com');
$site=new NewsGrabber::Bsdtoday_Com;
$site->Bsdtoday_Com_print_news;
$grabber->print_title_end;

$grabber->print_title(Newsforge,'News','http://www.newsforge.net');
$site=new NewsGrabber::Newsforge_Net;
$site->Newsforge_Net_print_news;
$grabber->print_title_end;

$grabber->print_title(Kuro5hin,'News','http://www.kuro5hin.org');
$site=new NewsGrabber::Kuro5hin_Org;
$site->Kuro5hin_Org_print_news;
$grabber->print_title_end;

$grabber->print_title(Linuxtoday,'News','http://www.linuxtoday.com');
$site=new NewsGrabber::Linuxtoday_Com;
$site->Linuxtoday_Com_print_news;
$grabber->print_title_end;

$grabber->print_title(Plastic,'News','http://www.plastic.com');
$site=new NewsGrabber::Plastic_Com;
$site->Plastic_Com_print_news;
$grabber->print_title_end;

$grabber->print_title('The Register','News','http://www.theregister.co.uk');
$site=new NewsGrabber::Theregister_Co_Uk;
$site->Theregister_Co_Uk_print_news;
$grabber->print_title_end;

$grabber->print_title('DotcomScoop','News','http://www.dotcomscoop.com');
$site=new NewsGrabber::Dotcomscoop_Com;
$site->Dotcomscoop_Com_print_news;
$grabber->print_title_end;

$grabber->print_title('Salon','News','http://www.salon.com');
$site=new NewsGrabber::Salon_Com;
$site->Salon_Com_print_news;
$grabber->print_title_end;

# Moreover feeds are different!!!
# Since Moreover.com gets feeds from other places,they have a lot (>300) feeds
# So we have a general call that can pass the URL of the RSS of a particular kind of news
# The list of RSS URLs can eb found at http://w.moreover.com/categories/category_list_rss.html
# An example with get the 'Cyber Culture' & 'Online Portal 'RSS feed is given below.
# The first parameter to be passed is the URL of the feed.
# Second parameter to be passed is the number of calls you are making to Moreover feed.
# i.e the first time you call Moreover_Com_print_news, paramater two should be 1 and the
# next time it should be 2 and so on.. 
# This is so that we can generate seperate files to store each RSS file.

$grabber->print_title('Online Portal','News - Moreover Feed','http://www.moreover.com');
$site=new NewsGrabber::Moreover_Com;
$site->Moreover_Com_print_news(url=>'http://p.moreover.com/cgi-local/page?c=Cyberculture%20news&o=rss',number=>1,age=>20);
$grabber->print_title_end;


$grabber->print_title('Cyber Culture','News - Moreover Feed','http://www.moreover.com');
$site->Moreover_Com_print_news(url=>'http://p.moreover.com/cgi-local/page?c=Online%20portals%20news&o=rss',number=>2);
$grabber->print_title_end;

# Print the HTML footer
# Template used is footer.template
$grabber->print_footer;

$site=undef;
$grabber=undef;

# End of script #
