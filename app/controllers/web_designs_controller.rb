class WebDesignsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  respond_to :html, :json

  add_breadcrumb  'Web Page Designs', :web_designs_url
  add_breadcrumb  'New Web Design', '', only: [:new, :create]
  add_breadcrumb  'Edit Page Design', '', only: [:edit, :update]

  def index 
    @businesses = Business.accessible_by( current_ability ).order("business_name asc") 
    if params[:business_id] 
      @business = Business.find(params[:business_id]) 
    else 
      @business = Business.accessible_by( current_ability ).first
    end
 
    @web_design = WebDesign.last
  end 

  def create 
    business = Business.find( params[:web_design][:business_id]  )
    authorize! :update, business
    create!
  end 

  def show 
    @web_design = WebDesign.find( params[:id] ) 
    authorize! :read, @web_design 
  end 

  def add_image
    @web_design = WebDesign.find( params[:id] )
    @web_design.web_images << WebImage.new( data: QqFile.parse(params[:qqfile], request))
    render json: {success: true}
  end

end
