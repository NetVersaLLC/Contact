class FailedJob < JobBase
  belongs_to :business
  belongs_to :screenshot

  def has_screenshot? 
    screenshot.present? && screenshot.data.present?
  end 

  def self.resolve_by_grouping_hash( group_hash ) 
    failed_jobs = FailedJob.where(grouping_hash: group_hash)
    failed_jobs.each do |failed_job| 
      payload ||= Payload.find( failed_job.payload_id ) # cache it.  

      Job.inject( failed_job.business, payload )     # requeue 
      failed_job.update_attribute( :resolved,  true )   # mark failure as fixed/resolved
    end 

    failed_jobs.length
  end 

  def self.errors_report(current_label=nil)
    label_filter = current_label && " and failed_jobs.label_id = #{current_label.id} " || ""
    FailedJob.connection.select_all("select sites.name, count(distinct failed_jobs.business_id) as customers_with_errors from failed_jobs inner join payloads on failed_jobs.payload_id = payloads.id inner join sites on sites.id = payloads.site_id where resolved = false #{label_filter} group by sites.name order by customers_with_errors desc")
  end
  def self.site_errors_report(site_name, current_label=nil)
    label_filter = current_label && " and failed_jobs.label_id = #{current_label.id} " || ""
    payloads_search = Site.where(name: site_name).first.payloads.pluck(:id).join(',')
    FailedJob.connection.select_all("select max(failed_jobs.id) as id, max(name) as name, max(status_message) as status_message, max(updated_at) as last_updated_at, count(distinct business_id) businesses_count, grouping_hash from failed_jobs where payload_id in (#{payloads_search}) #{label_filter} group by grouping_hash") 
  end 
end
