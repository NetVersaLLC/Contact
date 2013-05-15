class PlacesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js
  def index
    @client = GooglePlaces.new(GOOGLE_API_KEY)
    @city   = Location.where(:city => params[:city], :state => params[:state]).first
    @res = {}
    if @city
      @res = @client.search(@city.latitude, @city.longitude, params[:company_name])
    end
    render json: @res
  end
  def show
      @client = GooglePlaces.new(GOOGLE_API_KEY)
    @res = {}
    if params[:reference]
      @res = @client.lookup(params[:reference])
    end

    ac = @res['result']['address_components']
    @res['city'] = ac.select{|s| s["types"].include?("locality")}
    if @res['city'].present?
      @res['city'] = ac.select{|s| s["types"].include?("locality")}.first["long_name"] || ''
    else
      @res['city'] = ac.select{|s| s["types"].include?("country")}.first["long_name"] || ''
    end
    @res['state'] = ac.select{|s| s["types"].include?("administrative_area_level_1")}
    if @res['state'].present?
       @res['state'] = ac.select{|s| s["types"].include?("administrative_area_level_1")}.first["long_name"] || ''
    else
      @res['city'] = ac.select{|s| s["types"].include?("country")}.first["long_name"] || ''
    end
    @res['zip'] = ac.select{|s| s["types"].include?("postal_code")}
    if @res['zip'].present?
      @res['zip'] = ac.select{|s| s["types"].include?("postal_code")}.first["long_name"] || ''
    else
      @res['city'] = ac.select{|s| s["types"].include?("country")}.first["long_name"] || ''
    end
    
    render json: @res
  end
end
