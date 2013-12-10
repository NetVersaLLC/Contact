class Job < JobBase
  belongs_to :business
  belongs_to :screenshot

  after_create :assign_position

  attr_accessible :payload, :data_generator, :status, :runtime
  attr_accessible :business_id, :name, :status_message, :backtrace, :waited_at, :position, :data,
                  :retries

  acts_as_tree :order => "position"

  validates :status,
    :presence => true,
    :format => { :with => /^\d+$/ }
  validates :status_message,
    :presence => true
  validates :payload,
    :presence => true
  validates :business_id,
    :presence => true

  TO_CODE = {
    :new       => 0,
    :running   => 1,
    :reserved1 => 2,
    :reserved2 => 3,
    :finished  => 4,
    :error     => 5
  }
  TO_SYM = TO_CODE.invert

  def assign_position
    pos = Job.where(:business_id => self.business_id).minimum(:position)
    if pos == nil
      self.position = self.id
    else
      self.position = pos - 1
    end
    self.save
  end

  def get_job_data(business, params)
    unless self['data_generator'].nil?
      logger.info "Executing: #{self['data_generator']}"
      eval self['data_generator']
    else
      {}
    end
  end

  def self.get_latest(business, name)
    p = Job.where(business_id: business.id, name: name).last
    f = FailedJob.where(business_id: business.id, name: name).last
    c = CompletedJob.where(business_id: business.id, name: name).last

    r = p
    r = f if f.present? && ( r.nil? || f.created_at > r.created_at )
    r = c if c.present? && ( r.nil? || c.created_at > r.created_at )
    r
  end

  def self.pending(business)
    # Notes by Jani:
    #  These conditions and if and else blocks looks confusing to me
    @job = Job.where('business_id = ? AND status IN (0,1) AND runtime < UTC_TIMESTAMP()', business.id).order(:position).first
    if @job != nil
      if @job.status == TO_CODE[:running]
        # If the job has been waited during the past hour then it will do nothing
        if @job.waited_at > Time.current - 1.hour
          nil
        # If the job has started running in the past hour
        else
          #   Why don't enqueue the job to run again?
          #   Is it due to the fact that the client might lost the context e.g. closed the program or lost the connection?

          # Reap a stalled/failed job
          #@job.with_lock do
          #  @job.status         = TO_CODE[:error]
          #  @job.status_message = 'Job never returned results.'
          #  @job.save
          #end
          #@job.is_now(FailedJob)
          @job.failure("still waiting")
          nil
        end
      else
        @job.with_lock do
          @job.status         = TO_CODE[:running]
          @job.status_message = 'Starting job'
          @job.waited_at      = Time.current
          @job.save
        end
        @job
      end
    else
      nil
    end
  end

  def success(msg='Job completed successfully')
    self.with_lock do
      self.status         = TO_CODE[:finished]
      self.status_message = msg
      self.save
    end
    
    # If the payload is leaf and it defines required columns (:to, :from), then update the mode and complete the job
    ref_payload= Payload.by_name(self.name)
    if not ref_payload.nil? and ref_payload.children.empty?
      current_mode= BusinessSiteMode.find_by_business_id_and_site_id(self.business_id, ref_payload.site.id)
      if current_mode.mode == ref_payload.from_mode
        current_mode.mode = ref_payload.to_mode
        current_mode.save
      end
    end
    self.is_now(CompletedJob)
  end

  def failure(msg='Job failed', backtrace=nil, screenshot=nil)
    self.with_lock do
      self.status         = TO_CODE[:new]
      self.status_message = msg
      self.backtrace      = (backtrace || '') + "\nUpdated at #{Time.now}\n" + (self.backtrace || '')
      self.screenshot_id  = screenshot.id if screenshot.present?
      self.retries = (retries || 0)+1
      self.runtime= Time.current+2.minutes
      self.save
    end
    retries >= 2  ? self.is_now(FailedJob) : self
  end

  def self.inject(business_id,payload,data_generator,ready = nil,runtime = Time.now, signature='')
    Job.create do |j|
      j.status         = TO_CODE[:new]
      j.status_message = 'Created'
      j.business_id    = business_id
      j.payload        = payload
      j.signature      = signature
      j.data_generator = data_generator
      j.ready          = ready
      j.runtime        = runtime
    end
  end

  def self.get(table, id)
    if table == 'jobs' or table == nil
      @job = Job.find(id)
    elsif table == 'failed_jobs'
      @job = FailedJob.find(id)
    elsif table == 'completed_jobs'
      @job = CompletedJob.find(id)
    end
    @job
  end

  def label_id
    self.business.label_id
  end
end

class BusinessSiteMode < ActiveRecord::Base
  belongs_to :business
  belongs_to :site
  attr_accessible :mode, :business_id, :site_id

  TO_CODE = {
      :initial => 1,
      :signup  => 2,
      :idle    => 4,
      :update  => 8
  }
  TO_SYM = TO_CODE.invert
end
