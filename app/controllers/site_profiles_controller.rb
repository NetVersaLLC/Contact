class SiteProfilesController < InheritedResources::Base
  load_and_authorize_resource 
  respond_to :html #,:xml, :json
  actions :all
  add_breadcrumb 'Site Profiles', :site_profiles_url


end 
