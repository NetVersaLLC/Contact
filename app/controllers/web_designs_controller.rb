class WebDesignsController < ApplicationController
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
    @web_designs = @business.web_designs 
    @web_design = WebDesign.last
  end 

  def create 
    business = Business.find( params[:web_design][:business_id]  )
    authorize! :update, business
    @web_design = WebDesign.create( params[:web_design] )
  end 

  def show 
    @web_design = WebDesign.find( params[:id] ) 
    authorize! :read, @web_design 
  end 

  def update 
    @web_design = WebDesign.find( params[:id] ) 
    authorize! :update, @web_design 
    @web_design.update_attributes( params[:web_design] )
    render :show
  end 
   

  def add_image
    @web_design = WebDesign.find( params[:id] )
    @web_design.web_images << WebImage.new( data: QqFile.parse(params[:qqfile], request))
    render json: {success: true}
  end

end
