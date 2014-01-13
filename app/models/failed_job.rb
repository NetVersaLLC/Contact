class FailedJob < JobBase
  belongs_to :business
  belongs_to :screenshot

  def has_screenshot? 
    screenshot.present? && screenshot.data.present?
  end 

  def self.resolve_by_grouping_hash( group_hash ) 
    failed_jobs = FailedJob.where(grouping_hash: group_hash)
    failed_jobs.each do |failed_job| 
      payload ||= Payload.find( failed_job.payload_id )

      Job.inject( failed_job.business_id, payload )
      failed_job.update_attribute( resolved: true )
    end 

    failed_jobs.length
  end 

  def self.errors_report
    FailedJob.connection.select_all("select sites.name, count(distinct failed_jobs.payload_id) as payloads_with_errors from failed_jobs inner join payloads on failed_jobs.payload_id = payloads.id inner join sites on sites.id = payloads.site_id group by sites.name order by sites.name")
  end
  def self.site_errors_report(site_name)
    payloads_search = Site.where(name: site_name).first.payloads.pluck(:id).join(',')
    FailedJob.connection.select_all("select max(failed_jobs.id) as id, max(name) as name, max(status_message) as status_message, max(updated_at) as last_updated_at, count(distinct business_id) businesses_count from failed_jobs where payload_id in (#{payloads_search}) group by grouping_hash") 
  end 
end
