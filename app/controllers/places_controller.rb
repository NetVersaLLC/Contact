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
    render json: @res
  end
end
