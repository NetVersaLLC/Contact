#!/usr/bin/perl

use strict;
use MozRepl;
use Data::Dumper qw/Dumper/;
use JSON;
use URI::Escape;

my $repl = MozRepl->new;
$repl->setup;

sub test {
  my $actual = 'https://www.bingbusinessportal.com/Node:%5BApplication%5D%5C%5CStructure%5C%5CContent%5C%5CCategories%5C%5CBusiness%5C%5CMaster%5C%5C10825%7B%7BView:Category%7D%7D.GetObjectListDataAsJSON?aDataTypeList=Formatted%20Name%2C%23Type%20Icon&aUse=Items&aCountSubNodes=Y&aResultCount=500&fLocale=en-us';
  my $attempt =  get_by_name_path('[Application]\\\\Structure\\\\Content\\\\Categories\\\\Business\\\\Master\\\\10825');

  if ($actual eq $attempt) {
    print "Success: $actual\n";
  } else {
    print "Failure:\n";
    print $actual, "\n";
    print $attempt, "\n";
  }
}

sub fetch_url($) {
  my $url = shift;
  $repl->execute("window.location.href='$url';");
  sleep 1;
  my $content = $repl->execute("window.document.body.innerHTML");
  $content =~ s/^"<pre>//;
  $content =~ s/<\/pre>"$//;
  return $content;
}

sub name_path_to_file($) {
  my $name_path = shift;
  $name_path =~ s/[^A-Za-z0-9]//g;
  return "cats/$name_path.json";
}

sub get_by_name_path {
  my $name_path = shift;
  my $file = &name_path_to_file($name_path);
  if (-e $file) {
    my $json = '';
    open FILE, "< $file" or die "Error: $!: $file";
    read FILE, $json, -s $file;
    close FILE;
    return decode_json($json);
  }
  my $escaped = uri_escape( $name_path . '{{' );
  $escaped .= 'View:Category';
  $escaped .= uri_escape( '}}.GetObjectListDataAsJSON' );
  my $url = "https://www.bingbusinessportal.com/Node:$escaped?aDataTypeList=Formatted%20Name%2C%23Type%20Icon&aUse=Items&aCountSubNodes=Y&aResultCount=500&fLocale=en-us";
  my $json = &fetch_url($url);
  open FILE, "> $file" or die "Error: $!: $file";
  print FILE $json;
  close FILE;
  return decode_json( $json );
}

sub fetch_and_parse($) {
  my $url = shift;
  decode_json( &fetch_url($url) );
}

sub recurse_into($) {
  my $node = shift;
  my $cats = &get_by_name_path($node);
  foreach my $cat (@$cats) {
    if ($cat->{'SubNodeCount'} > 0) {
      print "Fetching: $$cat{'Formatted Name'}\n";
      &recurse_into($cat->{'NamePath'});
      sleep(1);
    }
  }
}

recurse_into('[Application]\\\\Structure\\\\Content\\\\Categories\\\\Business\\\\Master');

#my $item = 'https://www.bingbusinessportal.com/Node:%5BApplication%5D%5C%5CStructure%5C%5CContent%5C%5CCategories%5C%5CBusiness%5C%5CMaster%5C%5C10361%5C%5C10925%7B%7BView:Category%7D%7D.GetObjectListDataAsJSON?aDataTypeList=Formatted%20Name%2C%23Type%20Icon&aUse=Items&aCountSubNodes=Y&aResultCount=500&fLocale=en-us';
