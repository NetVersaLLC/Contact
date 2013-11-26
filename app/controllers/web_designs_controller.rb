class WebDesignsController < InheritedResources::Base
  load_and_authorize_resource 
  respond_to :html, :json
  actions :all

  add_breadcrumb 'Web Page Designs', :web_designs_url
  add_breadcrumb  'New Web Design', '', only: [:new, :create]
  add_breadcrumb  'Edit Page Design', '', only: [:edit, :update]

end
