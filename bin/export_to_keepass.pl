#!/usr/bin/perl

use strict;
use File::KeePass;
use File::Temp qw/tempfile/;
use Data::Dumper qw/Dumper/;
use IPC::Open3;
use JSON qw/decode_json/;

#my $input;
#{
#  local $/=undef;
#  $input = <STDIN>;
#}

my $bid = shift @ARGV;
my $dir = "/home/ubuntu/contact/current";
chdir $dir;
my $cmd  = "RAILS_ENV=production bundle exec rake businesses:export[$bid] --trace";
my $pid = open(PH, "$cmd 2>&1 1>/dev/null |") or die "Error: $cmd: $!\n";
$|=1;
my $i    = 0;
my $goal = 0;
my $start = 'false';
while (my $line = <PH>) {
  chomp($line);
  if ($line =~ /^Count: (\d+)/) {
    $goal  = $1;
    $start = 'true';
  } elsif ($line =~ /^Error: (.*)/) {
    print $line, "\n";
    exit;
  } else {
    if ($start eq 'true') {
      $i += 1;
      print "$goal:$i\n";
    }
  } 
}

my $input;
my $json = "/tmp/$bid.json";
open JSON, $json
  or die "Error: $json: $!\n";
read JSON, $input, -s $json;
close JSON;
my @entries = @{decode_json($input)};
print STDERR "Remote file: $json\n";

my $db = File::KeePass->new();
my $file = "/tmp/$bid.kdbx";

my $group = $db->add_group({
  'title' => 'KeePassHttp Passwords'
});
my $gid = $group->{'id'};

foreach my $entry (@entries) {
  # print Dumper($entry), "\n";
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

print "Output: $file\n";
