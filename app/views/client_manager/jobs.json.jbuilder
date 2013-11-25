json.jobs @jobs do |job| 
  json.id             job.id
  json.status         job.status 
  json.name           job.name 
  json.status_message job.status_message 
  json.created_at     job.created_at
  json.can_rerun      job.persisted? && job.class.name != "Job"
  json.is_missing     job.new_record?
  json.has_errors     job.class.name == "FailedJob" 
  json.has_screenshot job.has_screenshot?
  json.screenshot_url job.has_screenshot? ? job.screenshot.data.url() :  ""
  json.thumb_url      job.has_screenshot? ? job.screenshot.data.url(:thumb) :  ""
  json.class_name     job.class.name
  json.payload        job.payload
  json.backtrace      job.backtrace
  json.data           job.data_generator
end 
