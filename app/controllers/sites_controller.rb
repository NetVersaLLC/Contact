class SitesController < InheritedResources::Base  #ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource 
  respond_to :html, :json

  add_breadcrumb 'Site Profiles', :sites_url

  def index
    @q = Site.search(params[:q])
    @sites = @q.result.accessible_by(current_ability).paginate(page: params[:page], per_page: 10).order("name asc")
  end 

  def create
    create! do |success, failure| 
      success.json { render action: 'show', status: :created, location: @site_profile }
      failure.json { render json: @site_profile.errors, status: :unprocessable_entity }
    end 
  end

  def update
    update! do |success, failure| 
      success.json { head :no_content }
      failure.json { render json: @site_profile.errors, status: :unprocessable_entity }
    end 
  end

  def destroy
    destroy! do |format|
      format.json { head :no_content }
    end
  end

end
