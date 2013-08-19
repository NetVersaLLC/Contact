class Task < ActiveRecord::Base
  belongs_to :business
  attr_accessible :status, :started_at, :business_id, :completed_at

  validate :status, inclusion: { in: %w(new running completed) } 

  def self.open 
    where(status: 'new')
  end 

  def self.request_sync( business )
    t = Task.where(business_id: business.id).open.first
    if t.nil?
      t = Task.create({business_id: business.id, started_at: Time.now} ) if t.nil?
    else
      t.started_at = Time.now
      t.save
    end
    t
  end 

  def self.start_sync( business ) 
    t = Task.where(business_id: business.id).open.first
    unless t.nil?
      business.create_jobs
      t.update_attributes(:started_at => Time.now, :status => 'running') 
      true
    else 
      false
    end 
  end 

  def self.complete( business ) 
    t = Task.where(business_id: business.id).where(status: 'running').first
    if t
      t.update_attributes({completed_at: Time.now, status: 'completed'}) 
      true 
    else 
      false 
    end 
  end 

  def self.get_last_sync( business )
    t = Task.where('business_id=? AND started_at > ?', business.id, Date.yesterday).first
    if t.nil?
      return "No sync queued"
    else
      t.started_at.strftime("Changes queued on %m/%d/%Y")
    end 
  end

end
