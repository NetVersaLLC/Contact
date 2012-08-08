class Job < ActiveRecord::Base
  belongs_to :business

  attr_accessible :payload, :model, :status, :wait
  attr_accessible :business_id, :name, :status_message, :returned, :waited_at, :position, :data

  validates :status,
    :presence => true,
    :format => { :with => /^\d+$/ }
  validates :status_message,
    :presence => true
  validates :payload,
    :presence => true
  validates :model,
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

  def data(business)
    unless self['model'].nil?
      eval "#{self['model']}.data(business)"
    else
      {}
    end
  end

  def self.pending(business)
    @job = Job.where('business_id = ? AND status IN (0,1)', business.id).first
    if @job != nil
      if @job.wait == true
        if @job.waited_at > Time.now - 1.hour
          nil
        else
          # Reap a stalled/failed job
          @job.with_lock do
            @job.wait           = false
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
          @job.wait           = true
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

  def self.inject(business_id,payload,model)
    Job.create do |j|
      j.status         = TO_CODE[:new]
      j.status_message = 'Created'
      j.business_id    = business_id
      j.payload        = payload
      j.model          = model
    end
  end

  def is_now(klass)
    obj = klass.create do |o|
      o.wait           = self.wait
      o.name           = self.name
      o.model          = self.model
      o.status         = self.status
      o.payload        = self.payload
      o.returned       = self.returned
      o.position       = self.position
      o.waited_at      = self.waited_at
      o.created_at     = self.created_at
      o.updated_at     = self.updated_at
      o.status_message = self.status_message
    end
    self.delete
    obj
  end
end
