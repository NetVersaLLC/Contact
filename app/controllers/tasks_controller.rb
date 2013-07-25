class TasksController < ApplicationController
  before_filter      :authenticate_user!
  # skip_before_filter :verify_authenticity_token
  def create
    logger.info "Task"
    business = Business.find(params[:business_id]) 

    # if they been paying their bill
    if business.label.funds_available > 0.0
      @task             = Task.new
      @task.business_id =  business.id
      @task.started_at  = Time.now

      if @task.save!
        flash[:notice] = 'Sync started'
      else
        flash[:notice] = "Error: #{@task.errors}"
      end
    else 
      flash[:notice] = 'Started the sync'
      LabelMailer.sync_disabled_email(business.label).deliver
    end 

    redirect_to request.referer + "?delay=true"
  end

end
