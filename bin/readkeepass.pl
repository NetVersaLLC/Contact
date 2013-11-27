#!/usr/bin/perl

use strict;
use File::KeePass;
use Data::Dumper qw(Dumper);


my $file = shift @ARGV;
my $master_pass;# = 'crowdGr1p';

my $db = File::KeePass->new;
$db->load_db($file, shift @ARGV);#, $master_pass);

print Dumper($db->groups());
