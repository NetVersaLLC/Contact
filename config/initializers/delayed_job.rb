Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'dj.log'))
Delayed::Worker.sleep_delay = 2
Delayed::Worker.destroy_failed_jobs = true
Delayed::Worker.max_run_time = 5.seconds
Delayed::Worker.max_attempts = 1
Delayed::Worker.default_priority = 5
Delayed::Worker.read_ahead = 5
Delayed::Worker.default_queue_name = 'scans'
# will execute all jobs realtime when set to true
Delayed::Worker.delay_jobs = true

