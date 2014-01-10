class FailedJob < JobBase
  belongs_to :business
  belongs_to :screenshot

  def has_screenshot? 
    screenshot.present? && screenshot.data.present?
  end 

  def self.errors_report
    FailedJob.connection.select_all("select sites.name, count(distinct failed_jobs.payload_id) as payloads_with_errors from failed_jobs inner join payloads on failed_jobs.payload_id = payloads.id inner join sites on sites.id = payloads.site_id group by sites.name order by sites.name")
  end
  def self.site_errors_report(site_name)
    site = Site.where(name: site_name).first
    rows = FailedJob.connection.select_all("select max(failed_jobs.id) as id, max(name) as name, count(failed_jobs.id) as count from failed_jobs where payload_id in (342,446,447,448,449,450,451,452,453) group by grouping_hash") 
  end 
end
