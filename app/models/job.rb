class Job < ActiveRecord::Base

  belongs_to :site_transition
  belongs_to :business

  has_many :job_payloads

  attr_accessible :business_id, :status, :created_at

  validates :status, :presence => true,
            :format => {:with => /^\d+$/}
  validates :business_id, :presence => true


  TO_CODE = {
      :new       => 0,
      :running   => 1,
      :reserved1 => 2,
      :reserved2 => 3,
      :finished  => 4,
      :error     => 5
  }
  TO_SYM = TO_CODE.invert

  def label_id
    self.business.label_id
  end
end

class JobPayload < ActiveRecord::Base
  belongs_to :site_event_payload
  belongs_to :job

  attr_accessible :created_at, :finished_at, :failed_at, :last_run, :retries, :messages

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
  attr_accessible :required, :order

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
      job.job_payloads= site_transition.site_event_payloads.map { |sep|
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