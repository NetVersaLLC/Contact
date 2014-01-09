class JobsController < ApplicationController
  prepend_before_filter :authenticate_user_from_token!

  skip_before_filter :verify_authenticity_token

  #until we find a better home for it.  Used by grinder 
  def credentials
    @info = {}
    begin
      @business = Business.find(params[:business_id])
      @user = @business.user
      @info = {:status => :success, :auth_token => @user.authentication_token, :name => @business.business_name, :subscription_active => @business.subscription.active, :paused => !@business.paused_at.nil?, :categorized => @business.categorized, :payloads => @business.list_payloads}
    rescue Exception => e
      @info = {:status => :error, :message => e.message, :backtrace => e.backtrace.join("\n")}
    end
    respond_to do |format|
      format.json { render json: @info }
    end
  end

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
    @business.update_attributes(client_checkin: Time.now, client_version: params[:version] || "0.0.0")

    @job = {:status => 'default'}

    # Please consider misc_methods.rb stopped? and stopped_because methods before adding anything new here.  
    if @business.categorized == false
      @job = {:status => 'no_categories'}
    elsif @business.stopped? #paused? 
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
        @job.start
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

    #@job = Job.inject(params[:business_id], payload.client_script, payload.data_generator, payload.ready, runtime)
    @job = Job.inject(params[:business_id], payload, runtime)
    @job.name = params[:name]
    @job.payload_id = payload.id

    if payload.parent
      site_name= params[:name].split('/')[0]
      parent_job= CompletedJob.where("business_id= ? and name= ? ",
                                      @business.id, "#{site_name}/#{payload.parent.name}").order('id desc').first
      @job.parent_id= parent_job.id if parent_job
    end
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

        # now that we have a bing account, we can create the other listings
        Task.request_sync( @job.business ) if @job.name == "Bing/SignUp"
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

  def rerun 
    failed = FailedJob.find(params[:id])
    authorize! :update, failed 

    job = failed.is_now(Job)
    job.status = 0
    job.status_message = 'Recreated'
    if job.save
      render json: true
    else 
      render json: false, status: :bad_request
    end 
  end 

  def delete_all 
    authorize! :delete,  Job

    if params[:business_id].blank?
      render json: false, status: :bad_request
    else 
      Job.where(:business_id => params[:business_id]).delete_all
      render json: true
    end 
  end 

  def destroy
    if %w(Job FailedJob CompletedJob).include? params[:class_name] 
      job = params[:class_name].constantize.find(params[:id])
      authorize! :delete,  job 
      job.delete 
    else 
      Job.where(:business_id => params[:business_id]).delete_all
    end 
    render json: true
  end

end
