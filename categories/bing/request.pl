#!/usr/bin/perl

use strict;
use MozRepl;
use Data::Dumper qw/Dumper/;
use JSON;

sub fetch_url($) {
  my $url = shift;
  $repl->execute("window.location.href='$url';");
  sleep 1;
  $repl->execute("window.document.body.innerHTML");
}

sub fetch_and_parse($) {
  my $url = shift;
  my $values = &fetch_url($url);
}

my $repl = MozRepl->new;
$repl->setup;

my $doc = &fetch_url('https://www.bingbusinessportal.com/Node:%5BApplication%5D%5C%5CStructure%5C%5CContent%5C%5CCategories%5C%5CBusiness%5C%5CMaster%7B%7BView:Category%7D%7D.GetObjectListDataAsJSON?aDataTypeList=Formatted%20Name%2C%23Type%20Icon&aUse=Items&aCountSubNodes=Y&aResultCount=500&fLocale=en-us');
