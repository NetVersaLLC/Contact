class FailedJobsController < InheritedResources::Base
  before_filter :authenticate_reseller!

  def index 
    if params[:site] 
      @rows = FailedJob.site_errors_report(params[:site])
      render 'site_errors_report'
    else 
      @rows = FailedJob.errors_report
    end 
  end 

  def resolve 
    number_of_errors_resolved = FailedJob.resolve_by_grouping_hash( params[:grouping_hash] )
    flash[:notice] = "#{number_of_errors_resolved} jobs were submitted for the resolved errors."
    redirect_to failed_jobs_path
  end 

end 
