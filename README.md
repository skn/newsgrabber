# newsgrabber
NewsGrabber Perl module. Version 1.0.31 as released on 30/March/2002.
It has been retired for over a decade but is put here as a piece of
personal history.

################################################################
      NewsGrabber.pm Perl module README                       #
################################################################

 Version    : 1.0.31

 Date       : March 30, 2002

 License    : Copyleft 2000,2001,2002 Srijith.K. All rights reserved
              This program is free software; you can redistribute 
              it and/or modify it under the same terms as Perl 
              iself.

 Author     : Srijith.K (srijith@srijith.net)

 Req.       : For this module to work, you will need:
               * Perl
               * LWP Perl module
		* XML::Parser module
               * Ability to run CGI scripts 

 Disclaimer : This package is provided "AS IS" and without
              any express or implied warranties, including,
              without limitation, the implied warranties of
              merchantibility and fitness for a particular
              purpose.
#################################################################
Project Website : http://backendnews.sourceforge.net
For all queries/bug submissions, please use the website.
################################################################


In this 1.0.31 version of this script 33 Perl modules are being 
distributed. This included two main modules "NewsGrabber.pm" and
"NewsGrabber_Getbackend.pm" and 31 website specific modules.

An example of a script that uses these modules can be used can 
be got by downloading the Using_NewsGrabber-1.0.31.tar.gz file 
from the project website (http://backendnews.sourceforge.net).

Installing this module
----------------------
1. Download the NewsGrabber-1.0.31.tar.gz into a directory.
   Let me call it "/home/abc/modules". 
2. Gunzip and Tar-xvf the file.
3. Now you have a directory /home/abc/modules/NewsGrabber
4. Depending on how cgi scripts are run on your server, you may need to
   give a 'chmod o+rx' for this directory.
5. cd to that dir. You will see another dir and two files 
   NewsGrabber.pm and NewsGrabber_Getbackend.pm
   Again you may need to 'chmod o+rx' the two .pm files and the
   directory.
6. cd to this new dir /home/abc/NewsGrabber/NewsGrabber.
   You will see 31 module files for the 31 sites.
   You may need to do 'chmod o+rx' all the files.
7. By default to get things to work you need not edit anything
   in these scripts. Leave them alone if you are new to perl 
   modules.
8. If you are using a proxy to connect to the network please do the following:
 
   (*) Open up the NewGrabber_Getbackend.pm located at
       /home/abc/modules/NewsGrabber and search for the line 
       my $proxy_server='';
   (*) Change that to point to your proxy server details. An example will be 
       my $proxy_server='http://proxy.mysite.com:8080'; 
   (*) If you need to authenticate before using the proxy, complete the following
       variables also - $proxy_username and $proxy_passwd
9. If you dont need the support for all these files and feel that it is taking
   to much space, you can just delete them. Deleting one .pm file 
   will not affect the working of the other files.

Using this module
-----------------
Download the Using_NewsGrabber-1.0.31.tar.gz  file from the project
website (http://backendnews.sourceforge.net) into your cgi-bin
directory and gunzip and tar -xvf it.

Read the README and follow the steps given.

CREDITS
-------
- Hackinthebox.Org,Cert.Org and TWLC.Net support contributed by 
  Engelbert Tristram (Engelbert.Tristram@Succurit.com)


CHANGE LOG
----------

Version 1.0.31
+*+*+*+*+*+*+*
- Removing support for Lansystems.com and Appwatch.com (dead)
- Adding support for TWLC.net, Cert.Org and Hackinthebox.Org
- Changed Arstechnica from the ultramode.txt to RDF feed
- Updated feed URL of Dotcomscoop and Linux.com

Version 1.0.30
+*+*+*+*+*+*+*
- First Stable version
- Extensive Beta testing finished
- Added a more graceful way of catching XML parser errors
- Added Basic Proxy Authentication ability

Version Beta 2.0.30
+*+*+*+*+*+**+*+*+*
+ Big changes in code:
  - Removed dependance on CGI.pm
  - Made working of each site file independent
    of each other's presence. Earlier one needed
    to have all of them together, bundled.
  - Ability to set the age of update from newsgrabber.pl
  - Stopped exporting functions all together. 
    Now each function has to be called OO style. 
    Will decrease the name space pollution.
  - Removed 'use NewsGrabber_Getbackend.pm'
    from individual site grabbers to the general
    NewsGrabber.pm file. Should decrease memory usage.
  - Built in the ability to pass parameters to all 
    Site_X_print_news() function calls. As of now passing
    only 'age'. Can be extended.

Version Beta 1.2.30
*+*+*+*+*+*+*+*+*+*
+ Changed and removed URL/sites that were not working:
  - Freshmeat      : Changed URL and codes
  - Geeknews.Org   : Dead, removed
  - N32BitsOnline  : Dead, removed
  - SoftwareCentre : Dead, removed
  - Weatherpaper   : Dead, removed
  - Packetstorm    : Changed URL and codes
+ Added support for:
  - Fileforum.betanews.com
  - Geeknews.net
  - Linuxtoday.com
  - Techdirt.com
  - Theregister.co.uk
  - plastic.com
  - moreover.com (general) > 300 feeds!
  - Salon.com
  - Dotcomscoop.com

Version Beta 1.1.25
*+*+*+*+*+*+*+*+*+*

+ Changed codes of some files to use XML::Parser module
  to handle XML files. This prevents mess up in HTML 
  print out. Change affects
  - Linux.com
  - Dotcomma.org
  - Webmonkey/Hotwired.com
  - Kuro5hin.org
  - Lwn.net
  - Mozilla.org
  - Newsforge.net
  - Slashdot.org
  - Weatherpaper.com

+ So, now you need XML::Parser installed to get the above
  mentioned site grabber files to work. This will give a 
  consistent, better performance (I hope!). 

Version Beta 1.0.25
*+*+*+*+*+*+*+*+*+*

+ Added support for 5 more news sites
  - Newsforge.net
  - Bsdtoday.com
  - Weatherpaper.com
  - Kuro5hin.org
  - Dotcomma.org
+ Corrected some spelling mistakes in README

