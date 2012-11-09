ActiveAdmin.register Job do
  index do
    column :business_id
    column :name
    column :data_generator
    column :status
    column :created_at
    column :waited_at
    default_actions
  end

  member_action :payload_list, :method => :get do
    @payloads = Payload.list(params[:id])
    render json: @payloads
  end
  member_action :rerun_job, :method => :put do
    @failed = FailedJob.find(params[:id])
    @job = @failed.is_now(Job)
    @job.status = 0
    @job.status_message = 'Recreated'
    @job.save
    render json: @job
  end
  collection_action :payloads_categories_list, :method => :get do
    @cats = Payload.sites
    render json: @cats
  end

  collection_action :pending_jobs, :method => :get do
    @jobs = Job.where('business_id = ? AND status IN (0,1)', params[:business_id]).order(:position)
    render json: @jobs
  end

  collection_action :failed_jobs, :method => :get do
    @jobs = FailedJob.where('business_id = ?', params[:business_id]).order(:position)
    render json: @jobs
  end

  collection_action :completed_jobs, :method => :get do
    @jobs = CompletedJob.where('business_id = ?', params[:business_id]).order(:position)
    render json: @jobs
  end

  member_action :view_payload, :method => :get do
    @job = Job.get(params[:table], params[:id])
    render :inline => CodeRay.scan(@job.payload, :ruby).page
  end

  member_action :view_meta, :method => :get do
    @job = Job.get(params[:table], params[:id])
    render :partial => '/admin/jobs/view_meta'
  end

  member_action :update_job, :method => :put do
    @job = Job.get(params[:table], params[:id])
    [:name, :data_generator, :status, :status_message, :position].each do |em|
      @job[em] = params[em]
    end
    if @job.save
      render json: true
    else
      render json: false
    end
  end

  member_action :delete_job, :method => :delete do
    @job = Job.get(params[:table], params[:id])
    if @job.delete
      render json: true
    else
      render json: false
    end
  end

  # NOTE: These poorly named things shouldn't be here
  # they should be in a differnt place, probably the
  # packages controller.
  member_action :assload, :method => :post do
    PackagesPayloads.create do |pac|
      pac.package_id = params[:id]
      pac.site = params[:category]
      pac.payload = params[:payload_id]
    end
    render json: true
  end
  member_action :removeass, :method => :delete do
    package = PackagesPayloads.find(params[:id])
    package.delete
    render json: true
  end
  # END NOTE

  member_action :create_job, :method => :post do
    payload = Payload.new( params[:category], params[:id] )
    job = Job.inject(params[:business_id], payload.payload, payload.data_generator, payload.ready)
    job.name = "#{params[:category]}/#{params[:id]}"
    job.save
    render json: true
  end
  member_action :reorder, :method => :post do
    business = Business.find(params[:id])
    if params[:table] == 'jobs'
      klass = Job
    elsif params[:table] == 'failed_jobs'
      klass = FailedJob
    elsif params[:table] == 'completed_jobs'
      klass = CompletedJob
    end
    em = JSON( params[:order] )
    em.each do |pos|
      job          = klass.where(:id => pos[1]).first
      unless job.nil?
        job.position = pos[0]
        job.save!
      end
    end
    render json: true
  end
end
