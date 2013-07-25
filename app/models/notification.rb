class Notification < ActiveRecord::Base
  attr_accessible :body, :business_id, :title, :url
  belongs_to :business

  scope :activate_subscription, where(:title => 'Activate Subscription') 

  def self.add_activate_subscription business 
    if business.notifications.activate_subscription.count == 0 
      n = Notification.new( { :title => 'Activate Subscription', :body => 'Activate your subscription and publish your business!', :url => "/businesses/#{business.id}/subscriptions/#{business.subscription.id}/edit" } ) 
      business.notifications << n 
    end 
  end 
end
