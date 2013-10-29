class Dashboard
  def initialize( user ) 
    @user = user 
  end 

  def client_checkin
    business.client_checkin
  end 

  def is_client_downloaded
    business.is_client_downloaded
  end 

  def alerts
    messages = []
    messages << :client_not_downloaded if not business.is_client_downloaded

    if business.client_checkin.nil?
      messages << :client_has_not_checked_in 
    elsif business.client_checkin < 1.week.ago
      messages << :client_down 
    end 
  
    messages << :no_alerts if messages.empty?
    messages
  end 

  def business 
    @bus ||= @user.businesses.first
  end 
end 
