class DashboardController < ApplicationController
  before_filter      :authenticate_user!

  def index 
    @dashboard = Dashboard.new( current_user )  
  end 

end 
