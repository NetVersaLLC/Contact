#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems'
require 'backburner'

Backburner.configure do |config|
  config.beanstalk_url    = ["beanstalk://127.0.0.1"]
  config.tube_namespace   = "some_app"
  config.on_error         = lambda { |e| STDERR.puts e }
  config.max_job_retries  = 3 # default 0 retries
  config.retry_delay      = 2 # default 5 seconds
  config.default_priority = 65536
  config.respond_timeout  = 120
end

class Beast
  include Backburner::Performable
  queue "test"
  queue_priority 500
  def job(job_id)
    STDERR.puts "got job id: #{job_id}"
  end
  def id
    5723
  end
end

b = Beast.new
b.async.job(1400)
