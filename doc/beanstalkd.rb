Backburner.configure do |config|
  config.beanstalk_url    = ["beanstalk://beanstalkd.netversa.com"]
  config.tube_namespace   = "contact"
  config.on_error         = lambda { |e| Airbrake.notify(e) }
  config.max_job_retries  = 3
  config.retry_delay      = 2
  config.default_priority = 65536
  config.respond_timeout  = 120
end
