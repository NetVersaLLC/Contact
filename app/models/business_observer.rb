class BusinessObserver < ActiveRecord::Observer 
  def after_create(business) 
    unless Rails.env == 'test' do 
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
