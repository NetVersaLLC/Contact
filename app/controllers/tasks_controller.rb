class TasksController < ApplicationController
  def create
    logger.info "Task"
    @task = Task.new
    @task.started_at = Time.now

    if @task.save!
      flash[:notice] = 'Sync started'
    else
      flash[:notice] = "Error: #{@task.errors}"
    end
    redirect_to request.referer
  end
end
