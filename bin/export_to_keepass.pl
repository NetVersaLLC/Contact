#!/usr/bin/perl

use strict;
use File::KeePass;
use JSON qw/decode_json/;
use File::Temp qw/tempfile/;

my ($input, @input);
{
  local $/=undef;
  $input = <STDIN>;
  @input = decode_json($input);
}

my $domain = shift @ARGV;
my $db = File::KeePass->new();
my ($fh,$file) = tempfile();
$fh->close();
unlink $file;
$file .= '.kdbx';

my $group = $db->add_group({
  'title' => $domain
});
my $gid = $group->{'id'};

foreach my $site (@input) {
  my $e = $db->add_entry({
    'title'    => $site->{'title'},
    'username' => $site->{'username'},
    'url'      => $site->{'url'},
    'password' => $site->{'password'},
    'group'    => $gid,
  });
}

$db->save_db($file, 'netversa');

print $file, "\n";
