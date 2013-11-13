
class Dashboard
  def initialize( user ) 
    @user = user 
  end 

  def task
    @task ||= business.tasks.last
  end 
    
  def sync_available? 
    sync = task.present? && task.started_at < 24.hours.ago
    business_valid? && sync
  end 

  def business_valid?
    business.present? && business.valid?
  end 

  def client_checkin
    if @user.reseller?
      return Time.now
    end
    business.client_checkin
  end 

  def is_client_downloaded
    if @user.reseller?
      return true
    end
    business.is_client_downloaded
  end 

  def alerts
    messages = []
    if @user.reseller?
      return messages
    end
    messages << :client_not_downloaded if not business.is_client_downloaded

    if business_valid? 
      if business.client_checkin.nil?
        messages << :client_has_not_checked_in 
      elsif business.client_checkin < 1.week.ago
        messages << :client_down 
      end 
    else 
      messages << :business_does_not_validate
    end
  
    messages << :no_alerts if messages.empty?
    messages
  end 

  def business 
    @bus ||= @user.businesses.first
  end 
end 
