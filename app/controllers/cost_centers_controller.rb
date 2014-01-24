class CostCentersController < InheritedResources::Base
  load_and_authorize_resource 

  respond_to :html, :json
  actions :all

  def create
    create!{ cost_centers_url }
  end 

end 

