class JobsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def index
    @business = Business.find(params[:business_id])
    if @business.user_id != current_user.id
      format.json { render json: {:error => 'No permissions'}, status: :unprocessable_entity }
      return
    end
    @job = Job.pending(@business)
    logger.info "Job is: #{@job.inspect}"
    if @job == nil
      @job = {:status => 'wait'}
    end
    respond_to do |format|
      format.json { render json: @job }
    end
  end

  def create
    @business = Business.find(params[:business_id])
    if @business.user_id != current_user.id
      format.json { render json: {:error => 'No permissions'}, status: :unprocessable_entity }
      return
    end
    @job = Job.new(params[:job])
    @job.business_id = @business.id
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
