class Job < JobBase
  belongs_to :business
  belongs_to :screenshot

  after_create :assign_position

  attr_accessible :payload, :data_generator, :status, :runtime
  attr_accessible :business_id, :name, :status_message, :backtrace, :waited_at, :position, :data

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

  def wait
    self.status == TO_CODE[:running]
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
    #@job = Job.where('business_id = ? AND status IN (0,1) AND runtime < NOW()', business.id).order(:position).first
    @job = Job.where('business_id = ? AND status IN (0,1) AND runtime < UTC_TIMESTAMP()', business.id).order(:position).first
    if @job != nil
      if @job.wait == true
        if @job.waited_at > Time.now - 1.hour
          nil
        else
          # Reap a stalled/failed job
          @job.with_lock do
            @job.status         = TO_CODE[:error]
            @job.status_message = 'Job never returned results.'
            @job.save
          end
          #if @job.name == "Bing/Signup"
          #  return @job.rerun_bing_signup
          #else
          #  @job.is_now(FailedJob)
          #end
          @job.is_now(FailedJob)
          nil
        end
      else
        @job.with_lock do
          @job.payload        = @job.payload
          @job.status         = TO_CODE[:running]
          @job.status_message = 'Starting job'
          @job.waited_at      = Time.now
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
    self.is_now(CompletedJob)
  end

  #def failure(msg='Job failed', backtrace=nil, screenshot=nil, delete_old=true)
  #  self.with_lock do
  #    self.status         = TO_CODE[:error]
  #    self.status_message = msg
  #    self.backtrace      = backtrace
  #    self.screenshot_id  = screenshot.id if screenshot.present?
  #    self.save
  #  end
  #  self.is_now(FailedJob, delete_old)
  #end
  def failure(msg='Job failed', backtrace=nil, screenshot=nil )
    if FailedJob.
        where(:business_id => business.id, :name => self.name).
        where("updated_at > ?", Time.now - 4.hours).
        count >= 2

      business.update_attribute(:paused_at,  Time.now)
      email_body= "The #{self.name} for the business{id, name}:{#{business.id}, #{business.name}} has failed. Business syncs have been paused."
      UserMailer.custom_email("admin@netversa.com", email_body, email_body).deliver
      self.is_now(FailedJob)
    else 
      self.update_attributes(status: TO_CODE[:new], status_message: "Recreated") 
      add_failed_job( { "status_message" => msg, "backtrace" => backtrace, "screenshot" => screenshot } )
    end 
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

  def rerun_bing_signup(message=nil, backtrace=nil, screenshot=nil)
    if FailedJob.
        where(:business_id => business.id, :name => "Bing/SignUp").
        where("created_at > ?", Time.now - 4.hours).
        count >= 2
      business.paused_at= Time.now
      business.save
      email_body= "The Bing/Signup for the business{id, name}:{#{business.id}, #{business.name}} has failed"
      UserMailer.custom_email("admin@netversa.com", email_body, email_body).deliver

      message ? self.failure(message, backtrace, screenshot) : self.is_now(FailedJob)
    else
      message ? self.failure(message, backtrace, screenshot, false) : self.is_now(FailedJob, false)
      self.status = TO_CODE[:new]
      self.status_message = 'Recreated'
      self.save
      self
    end
  end
end
