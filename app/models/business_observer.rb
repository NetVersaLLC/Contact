class BusinessObserver < ActiveRecord::Observer 
  def after_create(business) 
   p = business.subscription.package 

   # p.package_payloads
   #   .select('distinct site')
   #   .where( site: %w(google zippro ezlocal localeze yellowee yahoo) )
   #   .each do |payload| 
   #      n = Notification.new( :title => "#{payload.site} Phone Verification", 
   #                       :url => "/businesses/#{business.id}/codes/new?site_name=#{payload.site.downcase}") 
   #      business.notifications << n
   #   end 

   business.post_to_leadtrac

    unless Rails.env == 'test' 
      business.create_site_accounts() 
      business.create_jobs() 
    end 
  end 

  def after_initialize(business) 
    business.set_times()
  end 

  def before_destroy(business) 
    business.delete_all_associated_records()
  end 

  def before_save(business)
    business.strip_blanks()
  end 
end 
