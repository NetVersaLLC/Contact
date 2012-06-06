class JobsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @job = Job.pending(current_user.id)
    if @job == nil
      @job = {:wait => true}
    end
    respond_to do |format|
      format.json { render json: @job }
    end
  end

  def create
    @job = Job.new(params[:job])
    @job.user_id = current_user.id

    respond_to do |format|
      if @job.save
        format.json { render json: @job, status: :created, location: @job }
      else
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @job = Job.find(params[:id])
    unless @job.user_id == current_user.id
      redirect_to '/', :status => 403
    else
      if params[:status] == 'success'
        @job.success(params[:message])
      else
        @job.failure(params[:message])
      end
      respond_to do |format|
        format.json { head :no_content }
      end
    end
  end

end
