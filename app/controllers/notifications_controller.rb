class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index 
    @notifications = Notification.where(:business_id => params[:busines_id] )
    render 'index', layout: false 
  end 


end 
