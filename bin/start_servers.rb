require 'rye'

rboxes = []
File.open(ARGV.shift, "r").each do |host|
  rboxes.push Rye::Box.new  host.strip, :user => 'ubuntu', :keys => ["/Users/jjeffus/Dropbox/NetVersa2.pem"], :sudo => true
end
rset = Rye::Set.new
rset.parallel = true
rboxes.each do |rbox|
  rset.add_boxes rbox
end
STDERR.puts rset.execute 'killall ruby'
sleep 1
STDERR.puts rset.execute 'service unicorn start'
sleep 1
STDERR.puts rset.execute 'ifconfig eth0'
STDERR.puts rset.ps('auxww')
