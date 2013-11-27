class WebDesignsController < InheritedResources::Base
  load_and_authorize_resource 
  skip_before_filter :verify_authenticity_token

  respond_to :html, :json
  actions :all

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
    authorize! :update, businesss 
    create!
  end 

  def add_image
    @web_image = WebImage.new( web_design_id: params[:id] )
    @web_image.data = QqFile.parse(params[:qqfile], request)
    @web_image.save

    render json: true #@web_image
  end

end
