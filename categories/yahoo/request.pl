#!/usr/bin/perl

use strict;
use MozRepl;

##
## Yahoo Local Category Download
##
## First install the Mozrepl plugin into Firefox
## https://addons.mozilla.org/en-us/firefox/addon/mozlab/
##
## Next you need the MozRepl library from cpan
## perl -MCPAN -eshell
## cpan> install MozRepl
##
## Go to submit your business on Yahoo Local.
## http://beta.listings.local.yahoo.com/signup/create_1.php?type=fl
##
## With your browser open here just run request.pl and the category JSON
## is saved into ./cats
##
## Next run ./parse.sh
##
## Fianlly, run:
## rake yahoo:categories
## to import categories.
##

my $repl = MozRepl->new;
$repl->setup;

foreach my $query ('aa' .. 'zz') { 
  $repl->execute("window.location.href='http://beta.listings.local.yahoo.com/ajaxcontroller?cmb=wo9R4tIRQwB&ts=0.9834929992917173&ws=getsubcategory&idx=1&seccat1=&seccat2=&seccat3=&seccat4=&seccat5=&regex=$query'");
  sleep(1);
  my $values = $repl->execute("window.document.body.innerHTML");
  open FILE, "> ./cats/$query.txt" or die "Error: $!\n";
  print FILE $values;
  close FILE;
}
