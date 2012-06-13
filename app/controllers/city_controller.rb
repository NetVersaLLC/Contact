class CityController < ApplicationController
  before_filter :authenticate_user!
  respond_to    :js
  def index
    @zips = Location.where('state = ? AND city LIKE ?', params[:state], "#{params[:term]}%").order(:city).group(:city).limit(10)
    respond_with(@zips)
  end
end
