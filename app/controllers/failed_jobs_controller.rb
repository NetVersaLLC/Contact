class FailedJobsController < ApplicationController
  before_filter :authenticate_failed_jobs

  def index 
    if params[:site] 
      @rows = FailedJob.site_errors_report(current_ability, params[:site])
      render 'site_errors_report'
    else 
      @rows = FailedJob.errors_report(current_ability)
    end 
  end 

  def show 
    @failed_job = FailedJob.find(params[:id])
    @failed_jobs_with_same_error = FailedJob.includes(:business).where(grouping_hash: @failed_job.grouping_hash)
  end 

  def resolve 
    number_of_errors_resolved = FailedJob.resolve_by_grouping_hash( params[:grouping_hash] )
    flash[:notice] = "#{number_of_errors_resolved} jobs were submitted for the resolved errors."
    redirect_to failed_jobs_path
  end 
  private 
    def authenticate_failed_jobs
      return if can? :read, FailedJob

      flash[:notice] = "You need to be an admin to access this part of the application"
      redirect_to root_path
    end 


end 
