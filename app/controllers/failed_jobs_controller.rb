class FailedJobsController < InheritedResources::Base
  before_filter :authenticate_reseller!

  def index 
    @rows = FailedJob.errors_report
  end 
end 
