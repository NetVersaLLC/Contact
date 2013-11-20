class ClientManagerController < ApplicationController 

  def index 
    @jobs = Job.where('business_id = ? AND status IN (0,1)', params[:business_id]).order(:position)
  end 

end 
