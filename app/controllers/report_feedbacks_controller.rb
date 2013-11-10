class ReportFeedbacksController < InheritedResources::Base
  load_and_authorize_resource
  respond_to :html, :json
  actions :all, except: [:update, :edit]

  def index
    add_breadcrumb "Reports Feedback", nil
    @q = ReportFeedback.search(params[:q])
    @records = @q.result.accessible_by(current_ability).paginate(page: params[:page] )
  end

  def show
    show! do
      add_breadcrumb "Reports Feedback", "report_feedbacks_path"
      add_breadcrumb @report_feedback.report.business, nil
    end
  end

end

