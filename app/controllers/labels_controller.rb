class LabelsController < InheritedResources::Base
  load_and_authorize_resource 

  respond_to :html, :json
  actions :all

  add_breadcrumb 'Labels', :labels_url
  add_breadcrumb 'Edit Label', nil, only: [:edit, :update]
  
end
