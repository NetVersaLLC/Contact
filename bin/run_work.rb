#!/usr/bin/env ruby
# encoding: utf-8



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
  def self.find(id)
    STDERR.puts "Getting: #{id}"
    return self.new
  end
end

Backburner.work('test')
