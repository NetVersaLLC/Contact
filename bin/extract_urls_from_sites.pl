#!/usr/bin/perl

open PIPE, "grep 'http' -ri * |" or die "Error: $!\n";
while (my $line = <PIPE>) {
  if ($line =~ m/^([^\/]+).*?:.*?['"](http.*?)['"]/i) {
    print "$1\t$2\n";
  }
}

