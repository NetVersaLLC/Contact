class CallCentersController < InheritedResources::Base
  load_and_authorize_resource 

  respond_to :html, :json
  actions :all

  def create
    create!{ call_centers_url }
  end 

end 

