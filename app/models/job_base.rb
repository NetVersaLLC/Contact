class JobBase < ActiveRecord::Base
  self.abstract_class = true

  def is_now(klass, delete_old: true)
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
    end
    self.delete if delete_old
    obj
  end

  def has_screenshot? 
    false 
  end 
end
