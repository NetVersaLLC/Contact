class CopyContactinfo < ActiveRecord::Migration
  def up
  	Business.order("updated_at desc").each do |b| 
  		u = b.user 
  		unless u.nil? || u.contact_first_name.present?
  			u.contact_gender = b.contact_gender
  			u.contact_prefix = b.contact_prefix
  			u.contact_first_name = b.contact_first_name
  			u.contact_last_name = b.contact_last_name
  			u.contact_middle_name = b.contact_middle_name
  			u.mobile_phone = b.mobile_phone 
  			u.mobile_appears = b.mobile_appears
  			u.save validate: false
  		end
  	end 
  end
end
