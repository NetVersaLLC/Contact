class ReportsController < InheritedResources::Base
  load_and_authorize_resource 
  respond_to :html, :json
  actions :all, except: [:update, :edit]

  add_breadcrumb 'Scan Reports', :reports_url
  add_breadcrumb  'New Report', '', only: [:new, :create]
  add_breadcrumb  'Edit Location', '', only: [:edit, :update]

  def index 
    @q = Report.search(params[:q])
    @reports = @q.result.accessible_by(current_ability).paginate(page: params[:page] )
  end   
end 