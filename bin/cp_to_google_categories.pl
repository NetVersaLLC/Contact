#!/usr/bin/env perl

##
## This script generates sql that copies the categories from the
## individual site tables over to the google categories.
##

use strict;
use DBI;
use JSON qw/decode_json/;
use Data::Dumper qw/Dumper/;

my ($json, @citations);
my ($dbh, $business_sth, $category_sth);

{
  local $|=undef;
  open PIPE, qq!ruby -rjson -e 'puts eval(File.read("lib/citation_list.rb")).to_json' |! or die "Error: $!";
  @citations = decode_json(<PIPE>);
  close PIPE;
}

$dbh = DBI->connect("dbi:mysql:contact_development", "root", "balls");

$business_sth = $dbh->prepare("SELECT id,category1 FROM businesses");
$category_sth = $dbh->prepare("SELECT id FROM google_categories WHERE name=?");
$business_sth->execute();
while (my $business = $business_sth->fetchrow_arrayref()) {
  $category_sth->execute( $business->[1] );
  if ($category_sth->rows() == 0) {
    print STDERR "Skipping: $$business[0]: $$business[1]\n";
    next;
  }
  my ($google_category_id) = $category_sth->fetchrow_array();
  foreach my $data (@{$citations[0]}) {
    my ($row) = $dbh->selectrow_hashref("SELECT * FROM $data->[1] WHERE business_id=$$business[0]");
    if ($row) {
      foreach my $item (@{$data->[2]}) {
        if ($item->[0] eq 'select') {
          # print $data->[1], ": ", Dumper($row), "\n";
          my $column_name = $item->[1]."_id";
          next if not exists $row->{$column_name} or not defined $row->{$column_name};
          print "UPDATE google_categories SET $column_name=".$dbh->quote($row->{$column_name})." wHERE id=$google_category_id;\n";
        }
      }
    }
  }
}
