class TasksController < ApplicationController
  before_filter      :authenticate_user!
  # skip_before_filter :verify_authenticity_token
  def create
    business = Business.find(params[:business_id]) 

    # if they been paying their bill
    if business.label.funds_available > 0.0
      @task = Task.request_sync( business )

      if @task.errors.empty?
        flash[:notice] = 'Changes queued'
      else
        flash[:notice] = "Error: #{@task.errors}"
      end
    else 
      flash[:notice] = 'Queued your changes'
      LabelMailer.sync_disabled_email(business.label).deliver
    end 

    redirect_to request.referer + "?delay=true"
  end

end
