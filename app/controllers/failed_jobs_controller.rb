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
end 
