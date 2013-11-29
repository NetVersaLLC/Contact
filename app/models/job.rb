class Job < ActiveRecord::Base

  belongs_to :site_transition
  belongs_to :business

  has_many :job_payloads, inverse_of: :job

  attr_accessible :business_id, :status, :created_at

  validates :status, :presence => true,
            :format => {:with => /^\d+$/}
  validates :business_id, :presence => true

  TO_CODE = { :new=> 0, :running=> 1, :reserved1=> 2,
              :reserved2=> 3, :finished=> 4, :error=> 5 }
  TO_SYM = TO_CODE.invert

  def finish
    ActiveRecord::Base.transaction do
      status= TO_CODE[:finished]
      save

      bss= BusinessSiteState.find_by_business_id_and_site_id(business.id, site_transition.site.id)
      bss.state= site_transition.to
      bss.save
    end
  end

end

class JobPayload < ActiveRecord::Base
  belongs_to :site_event_payload
  belongs_to :job, inverse_of: :job_payloads

  attr_accessible :created_at, :finished_at, :failed_at, :last_run, :retries, :messages, :result, :job_id

  def next(jp_result, msg)
    result= jp_result
    messages= (messages or "") + msg
    last_run= Time.now
    if result == "error"
      failed_at = Time.now
      save
      return {:result => :failed, :next_job_payload => nil}
    else
      finished_at= Time.now
      save
      if not site_event_payload.next_if_true and not site_event_payload.next_if_false
        job.finish
        return {:result => :finished, :next_job_payload => nil}
      else
        new_jp= JobPayload.new({:job_id => job_id})
        new_jp.site_event_payload= SiteEventPayload.find(result ? site_event_payload.next_if_true : site_event_payload.next_if_false)
        new_jp.created_at= Time.now
        new_jp.save
        return {:result => :finished, :next_job_payload => new_jp}
      end
    end
  end
end


# A site needs a state list which contains current state and next state and the event which fires the trnasition
# There is a collection of payloads which needed to run successfully to complete the transition
# This class contains all the above data
class SiteTransition < ActiveRecord::Base
  belongs_to :site
  has_many :payloads, :through => :site_event_payloads
  has_many :site_event_payloads

  attr_accessible :from, :site_id, :to, :on

end

class SiteEventPayload < ActiveRecord::Base
  belongs_to :site_transition
  belongs_to :payload
  belongs_to :next_if_false, :class_name=> "SiteEventPayload"
  belongs_to :next_if_true, :class_name=> "SiteEventPayload"
  attr_accessible :required, :step_no , :next_if_true_id, :next_if_false_id

end


# Persist the current state for each business for all relevant websites that the business subscribed to
class BusinessSiteState < ActiveRecord::Base
  belongs_to :business
  belongs_to :site

  attr_accessible :state

  def on_transition
    ActiveRecord::Base.transaction do
      job= Job.new
      site_transition = SiteTransition.find_by_site_id_and_from(site_id, state)
      job.job_payloads= site_transition.site_event_payloads.order(:step_no).take(1).map { |sep|
        JobPayload.new { |jp|
          jp.created_at= Time.now
          jp.site_event_payload= sep
          jp.job = job
        }
      }
      job.business_id= business_id
      job.status= Job::TO_CODE[:new]
      job.site_transition_id= site_transition.id
      job.save
      job
    end
  end

  def fire_event event
    @event= event
    on_transition
  end

  def transitions
    return [] if site_id.nil?
    SiteTransition.where("site_id= ?", site_id).map { |c| {c.from => c.to, :on => c.on} }
  end

end