class ZipController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js
  def index
   #@city = Location.where(:zip => params[:term]).last
   @city = Location.city_and_state_from_zip( params[:term] ) 
   logger.info "R=#{@city.inspect}"

   render json: @city
  end
end
