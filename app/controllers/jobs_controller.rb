class JobsController < ApplicationController
  before_filter      :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def index
    @business = Business.find(params[:business_id])
    if @business.user_id != current_user.id
      respond_to do |format|
        format.json {
          render json: {:error => 'No permissions'},
            status: :unprocessable_entity
        }
      end
      return
    end
    @business.checkin()

    @job = {:status => 'default'}
    if @business.categorized == false
      @job = {:status => 'no_categories'}
    elsif @business.paused? == true
      @job = {:status => 'paused'}
    elsif (@business.subscription != nil and @business.subscription.active?) == false
      @job = {:status => 'inactive'}
    else
      @job = Job.pending(@business)
      logger.info "Job is: #{@job.inspect}"

      # when there is nothing to do, look for something to do
      if @job.nil?
        Task.complete(@business) 
        Task.start_sync(@business) 

        @job = {:status => 'wait'} # jobs are being inserted in the background.  
      else
        @job['payload_data'] = @job.get_job_data(@business, params)
      end
    end
    respond_to do |format|
      format.json { render json: @job }
    end
  end

  def create
    @business = Business.find(params[:business_id])

    payload = Payload.start(params[:name])
    if payload == nil
      respond_to do |format|
        format.json { render json: {:error => 'Not Found'}, status: :not_found}
      end
      return
    end

    if params[:delay]
      runtime = Time.now + params[:delay].to_i*60
    else
      runtime = Time.now - 5.hours
    end

    if params[:clear] and params[:clear] == 'before'
      Job.where(:business_id => params[:business_id]).delete_all
    end

    @job = Job.inject(params[:business_id], payload.name, payload.data_generator, payload.ready, runtime)
    @job.name = params[:name]
    @job.save

    respond_to do |format|
      if @job.save
        format.json { render json: @job }
      else
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @job = Job.find(params[:id])

    unless @job.business.user_id == current_user.id
      redirect_to '/', :status => 403
    else
      if params[:status] == 'success'
        @job.success(params[:message])
      else
        @screenshot = nil
        if params[:screenshot]
          @screenshot = Screenshot.new
          @screenshot.data = QqFile.parse(params[:screenshot], request)
          @screenshot.save
        end
        @failed_job = @job.failure(params[:message], params[:backtrace], @screenshot)
      end
      respond_to do |format|
        format.json { head :no_content }
      end
    end
  end

  def list
    @jobs = Job.where('business_id = ? AND status IN (0,1)', params[:business_id]).order(:position)
    final = []
    @jobs.each do |job|
      final.push({
        :id          => job.id,
        :business_id => job.business_id,
        :name        => job.name,
        :status      => job.status,
        :waited_at   => job.waited_at,
        :updated_at  => job.updated_at
      })
    end
    render json: final
  end

  def remove
    @job = Job.find( params[:id] )
    @job.delete
    render json: true
  end

  def booboo
    render json: true
  end

  def destroy
    Job.where(:business_id => params[:business_id]).delete_all
    render json: true
  end

end
