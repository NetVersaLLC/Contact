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

  def self.errors_report(current_ability)
   sql = %(select sites.name, count(distinct failed_jobs.business_id) as customers_with_errors 
      from failed_jobs 
        inner join payloads on failed_jobs.payload_id = payloads.id 
        inner join sites on sites.id = payloads.site_id
      where resolved = false #{auth_filter(current_ability)} 
      group by sites.name 
      order by customers_with_errors desc) 

    FailedJob.connection.select_all(sql)
  end

  def self.site_errors_report(current_ability, site_name)
    filter = auth_filter(current_ability)
    payloads_search = Site.where(name: site_name).first.payloads.pluck(:id).join(',')

    FailedJob.connection.select_all("select max(failed_jobs.id) as id, max(name) as name, max(status_message) as status_message, 
      max(updated_at) as last_updated_at, count(distinct business_id) businesses_count, grouping_hash 
      from failed_jobs where payload_id in (#{payloads_search}) #{filter} 
      group by grouping_hash") 
  end 

  private 
    def self.auth_filter(current_ability) 
      if current_ability.can?(:create, Label) 
        ids = Label.accessible_by(current_ability).pluck(:id).join(',')
        " and failed_jobs.label_id in (#{ids}) " 
      else 
        ids = Business.accessible_by(current_ability).pluck(:id).join(',')
        " and failed_jobs.business_id in (#{ids}) " 
      end 
    end 
end
