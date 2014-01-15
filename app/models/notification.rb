class Notification < ActiveRecord::Base
  attr_accessible :body, :business_id, :title, :url
  belongs_to :business
  
  before_save :prevent_duplicates

  scope :activate_subscription, where(:title => 'Activate Subscription') 

  def self.add_activate_subscription business 
    if business.notifications.activate_subscription.count == 0 
      n = Notification.new( { :title => 'Activate Subscription', :body => 'Activate your subscription and publish your business!', :url => "/businesses/#{business.id}/subscriptions/#{business.subscription.id}/edit" } ) 
      business.notifications << n 
    end 
  end 

  private 

    def prevent_duplicates 
      Notification.where( url: self.url, business_id: self.business_id).delete_all
    end 

end
