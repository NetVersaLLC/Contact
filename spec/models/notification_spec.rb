require 'spec_helper'

describe Notification do

  it 'should never have a duplicate' do 
    business = create(:business) 

    3.times do 
      notification = business.notifications.new
      notification.url = "/businesses/#{business.id}/codes/new?site_name=google&next_job=notify"
      notification.title = "Google Account SignUp"
      notification.save
    end 
    2.times do 
      notification = Notification.new
      notification.business_id = business.id + 1
      notification.url = "/businesses/#{business.id+1}/codes/new?site_name=google&next_job=notify"
      notification.title = "Google Account SignUp"
      notification.save
    end 

    Notification.all.count.should eq(2)

  end 

end 

