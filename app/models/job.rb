cTask.request_sync( @job.business ) lass Job < JobBase
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
    #
    # Find the next job in the queue while skipping those payloads that have been paused.  
    # 2014-01-01 Job.payload_id was not being set, so this ridiculous join had to be used instead.  In a few days when all the jobs that are 
    #            missing the ID have been ran, the join can be shortened to use the payload_id instead 
    @job = Job.joins("inner join sites on sites.name = left( jobs.name, locate('/', jobs.name)-1) inner join payloads on payloads.site_id = sites.id and payloads.name = right( jobs.name, length(jobs.name) - locate('/', jobs.name) ) ")
      .where('business_id = ? AND status IN (0,1) AND runtime < UTC_TIMESTAMP() and payloads.paused_at is null', business.id).order(:position).first

    if @job != nil
      @job = Job.find(@job.id) # this is necessary to get an activerecord object instead of a read only object

      if @job.wait == true
        if @job.waited_at < Time.now - 15.minutes
          # Reap a stalled/failed job
          @job.status         = TO_CODE[:error]
          @job.status_message = 'Job never returned results.'
          @job.save

          @job.is_now(FailedJob)
        end
        nil
      else
        @job
      end
    else
      nil
    end
  end

  def start
    self.status         = TO_CODE[:running]
    self.status_message = 'Starting job'
    self.waited_at      = Time.now
    self.save!
  end 

  def success(msg='Job completed successfully')
    self.with_lock do
      self.status         = TO_CODE[:finished]
      self.status_message = msg
      self.save
    end
    # If the payload is leaf and it defines required columns (:to, :from), then update the mode and complete the job
    payload= Payload.by_name(self.name)
    if payload and payload.children.empty?
      mode= BusinessSiteMode.find_or_initialize_by_business_id_and_site_id(self.business_id, payload.site.id)
      if mode.new_record?
        mode.mode_id= payload.to_mode_id
        mode.save
      elsif mode.mode_id == payload.mode_id
        mode.mode_id = payload.to_mode_id
        mode.save
      else
        logger.error "#{self.name} payload mode:#{payload.mode_id} does not match the current mode: #{mode.mode_id}"
      end
    end
    self.is_now(CompletedJob)
  end

  def failure(msg='Job failed', backtrace=nil, screenshot=nil )
    job_retries= (Contact::CONFIG ? Contact::CONFIG[Rails.env]["job_retries"] : 2)
    if FailedJob.
        where(:business_id => business.id, :name => self.name).
        where("updated_at > ?", Time.now - 4.hours).
        count >= job_retries

      if self.name == "Bing/Signup"
        business.update_attribute(:paused_at,  Time.now)
        email_body= "The #{self.name} for the business{id, name}:{#{business.id}, #{business.name}} has failed. Business syncs have been paused."
        UserMailer.custom_email("admin@netversa.com", email_body, email_body).deliver
      else
        payload= Payload.by_name(self.name)
        payload.update_attributes(paused_at: Time.now)
      end
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

end
