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
    reque = params[:inject].present? 
    number_of_errors_resolved = FailedJob.resolve_by_grouping_hash( params[:grouping_hash], reque)

    current_user.rewards << Reward.new( points: number_of_errors_resolved * 100 ) if current_user.is_a? Administrator

    flash[:notice] = "#{number_of_errors_resolved} errors were updated."
    redirect_to :back
  end 
  private 
    def authenticate_failed_jobs
      return if can? :read, FailedJob

      flash[:notice] = "You need to be an admin to access this part of the application"
      redirect_to root_path
    end 


end 
