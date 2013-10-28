class BusinessObserver < ActiveRecord::Observer 
  def after_create(business) 
   p = business.subscription.package 
   business.post_to_leadtrac

   unless Rails.env == 'test'
    # business.create_site_accounts()
    # business.create_jobs()
   end
  end

  def after_initialize(business)
    business.set_times()
  end

  def before_save(business)
    business.strip_blanks()
  end
end
