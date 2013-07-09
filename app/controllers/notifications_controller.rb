class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index 
    @notifications = Notification.where(:business_id => params[:business_id])
    render 'index', layout: false
  end 

  def show 
    @notificaiton = Notification.find(params[:id]) 
  end 

end
