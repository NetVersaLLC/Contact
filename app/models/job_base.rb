class JobBase < ActiveRecord::Base
  self.abstract_class = true

  def is_now(klass, delete_old=true)
    obj = klass.create do |o|
      o.name           = self.name
      o.business_id    = self.business_id
      o.data_generator = self.data_generator
      o.status         = self.status
      o.payload        = self.payload
      o.position       = self.position
      o.backtrace      = self.backtrace
      o.waited_at      = self.waited_at
      o.created_at     = self.created_at
      o.updated_at     = self.updated_at
      o.screenshot_id  = self.screenshot_id
      o.status_message = self.status_message
      o.payload_id     = self.payload_id
      o.label_id       = self.label_id

      o.grouping_hash = get_grouping_hash if o.attribute_names.include?('grouping_hash') 
    end
    self.delete if delete_old
    obj
  end

  def add_failed_job( new_values )
    failed_attributes =  FailedJob.attribute_names
    failed = self.attributes.merge( new_values ).select{|k,v| failed_attributes.include?( k )}

    fj = FailedJob.new( failed )
    fj.grouping_hash = fj.get_grouping_hash()
    fj.save
    fj
  end 
    
  def has_screenshot? 
    false 
  end 

  def get_grouping_hash
    bt = (backtrace||"").gsub(/:0x.*>/,"") # strip object id 

    Digest::MD5.hexdigest( "#{payload_id}#{status_message}#{bt}")
  end 
end
