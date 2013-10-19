#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

$running = true
Signal.trap("TERM") do 
  $running = false
end

Signal.trap("SIGTERM") do
  $running = false
end

while($running) do
  ActiveRecord::Base.connection_pool.clear_stale_cached_connections!
  Scan.send_all_waiting_tasks!
  Scan.resend_long_waiting_tasks!
  Scan.fail_tasks_that_waiting_too_long!
  sleep 2
end
