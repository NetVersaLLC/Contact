class FailedJobsController < InheritedResources::Base
  before_filter :authenticate_reseller!

  def index 
    label_filter = current_user.admin? ? nil : current_label 
    if params[:site] 
      @rows = FailedJob.site_errors_report(params[:site], label_filter)
      render 'site_errors_report'
    else 
      @rows = FailedJob.errors_report(label_filter)
    end 
  end 

  def resolve 
    number_of_errors_resolved = FailedJob.resolve_by_grouping_hash( params[:grouping_hash] )
    flash[:notice] = "#{number_of_errors_resolved} jobs were submitted for the resolved errors."
    redirect_to failed_jobs_path
  end 

end 
