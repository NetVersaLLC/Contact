class SiteProfilesController < InheritedResources::Base
  load_and_authorize_resource 
  respond_to :html #,:xml, :json
  actions :all
  add_breadcrumb 'Site Profiles', :site_profiles_url

  def index
    @q = SiteProfile.search(params[:q])
    @site_profiles = @q.result.accessible_by(current_ability).paginate(page: params[:page], per_page: 10).order("site asc")
  end 

end 
