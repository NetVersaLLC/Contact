class Job < JobBase
  belongs_to :business

  attr_accessible :payload, :data_generator, :status
  attr_accessible :business_id, :name, :status_message, :returned, :waited_at, :position, :data

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

  def self.pending(business)
    @job = Job.where('business_id = ? AND status IN (0,1)', business.id).order(:position).first
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
        @job.with_lock do
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

  def success(msg='Job completed successfully', returned=nil)
    self.with_lock do
      self.status         = TO_CODE[:finished]
      self.status_message = msg
      self.returned       = returned
      self.save
    end
    self.is_now(CompletedJob)
  end

  def failure(msg='Job failed', returned=nil)
    self.with_lock do
      self.status         = TO_CODE[:error]
      self.status_message = msg
      self.returned       = returned
      self.save
    end
    self.is_now(FailedJob)
  end

  def self.inject(business_id,payload,data_generator,ready = nil)
    Job.create do |j|
      j.status         = TO_CODE[:new]
      j.status_message = 'Created'
      j.business_id    = business_id
      j.payload        = payload
      j.data_generator = data_generator
      j.ready          = ready
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
end
