#!/usr/bin/perl

use strict;
use File::KeePass;
use JSON qw/decode_json/;
use File::Temp qw/tempfile/;
use Data::Dumper qw/Dumper/;

my $input;
{
  local $/=undef;
  $input = <STDIN>;
}
my @entries = @{decode_json($input)};

my $db = File::KeePass->new();
my ($fh,$file) = tempfile();
$fh->close();
unlink $file;
$file .= '.kdbx';

my $group = $db->add_group({
  'title' => 'KeePassHttp Passwords'
});
my $gid = $group->{'id'};

foreach my $entry (@entries) {
  print Dumper($entry), "\n";
  if (exists $entry->{'email'}) {
    my $e = $db->add_entry({
      'title'    => $entry->{'model'},
      'username' => $entry->{'email'},
      'url'      => $entry->{'login_url'},
      'password' => $entry->{'password'},
      'group'    => $gid,
    });
  } elsif (exists $entry->{'username'}) {
    my $e = $db->add_entry({
      'title'    => $entry->{'model'},
      'username' => $entry->{'username'},
      'url'      => $entry->{'login_url'},
      'password' => $entry->{'password'},
      'group'    => $gid,
    });
  }
}

$db->save_db($file, 'netversa');

print $file, "\n";
