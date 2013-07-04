class TasksController < ApplicationController
  def create
    business_id = params['business_id']

    # TODO This is a temporary fix until https://www.pivotaltracker.com/story/show/49324723 has been 
    # completed.  We dont want to insert any updated jobs until the sign-up jobs have 
    # finished.  
    if CompletedJob.where(business_id: business_id).first.nil? 
      @task = nil
    else 
      logger.info "Task #{business_id}"
      @task             = Task.new
      @task.business_id = business_id
      @task.started_at  = Time.now

      business = Business.find(business_id)
      business.update_jobs
    end 

    if @task.nil? || @task.save
      flash[:notice] = 'Sync started'
    else
      flash[:notice] = "Error: #{@task.errors}"
    end
    redirect_to request.referer + "?delay=true"
  end

end
