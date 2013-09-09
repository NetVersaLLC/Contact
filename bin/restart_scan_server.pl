#!/usr/bin/perl

print "Stopping scan server...\n";
open PIPE,  "ps auxww|";
while (my $line = <PIPE>) {
	if ($line =~ /ubuntu\s*(\d+)/) {
		my $pid = $1;
		if ($line =~ /delayed_job/) {
			print("killing $pid...\n");
			system("kill $pid");
		}
	}
}
sleep 10;
print "Staring scan server...\n";
system "sudo service backburner start";
