class Job < JobBase
  belongs_to :business
  belongs_to :screenshot

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
          @job.is_now(FailedJob)
          nil
        end
      else
        open_browser =<<END
@browser = Watir::Browser.new
at_exit do
  if @browser
    @browser.close
  end
end

END
        @job.with_lock do
          unless @job.model == 'Test' or @job.model == 'Utils'
            @job.payload = open_browser + @job.payload
          end
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

  def failure(msg='Job failed', backtrace=nil, screenshot=nil)
    self.with_lock do
      self.status         = TO_CODE[:error]
      self.status_message = msg
      self.backtrace      = backtrace
      self.screenshot_id  = screenshot.id
      self.save
    end
    self.is_now(FailedJob)
  end

  def self.inject(business_id,payload,data_generator,ready = nil,runtime = Time.now)
    Job.create do |j|
      j.status         = TO_CODE[:new]
      j.status_message = 'Created'
      j.business_id    = business_id
      j.payload        = payload
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
