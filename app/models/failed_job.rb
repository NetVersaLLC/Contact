class FailedJob < JobBase
  belongs_to :business
  belongs_to :screenshot

  def has_screenshot? 
    screenshot.present? && screenshot.data.present?
  end 

  def self.site_errors_report
    FailedJob.connection.select_all("select sites.name, count(distinct failed_jobs.payload_id) as payloads_with_errors from failed_jobs inner join payloads on failed_jobs.payload_id = payloads.id inner join sites on sites.id = payloads.site_id group by sites.name order by sites.name")
  end
end
