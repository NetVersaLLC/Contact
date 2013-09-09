#!/usr/bin/perl

use strict;
use File::KeePass;
use JSON qw/decode_json/;
use File::Temp qw/tempfile/;

# my $input;
#{
#  local $/=undef;
#  $input = <STDIN>;
#}

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

my $e = $db->add_entry({
  'title'    => 'Something',
  'username' => 'someuser',
  'url'      => 'http://binsearch.info',
  'password' => 'somepass',
  'group'    => $gid,
});

$db->save_db($file, 'netversa');

print $file, "\n";
