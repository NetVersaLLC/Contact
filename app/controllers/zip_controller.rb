class ZipController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js
  def index
   @city = Location.where(:zip => params[:term]).last
   render json: @city
  end
end
