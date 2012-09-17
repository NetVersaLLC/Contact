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
    if params[:table] == 'jobs'
      job = Job.find(params[:id])
    elsif params[:table] == 'failed_jobs'
      job = FailedJob.find(params[:id])
    elsif params[:table] == 'completed_jobs'
      job = CompletedJob.find(params[:id])
    end
    render :inline => CodeRay.scan(job.payload, :ruby).page
  end
  member_action :view_meta, :method => :get do
    if params[:table] == 'jobs'
      @job = Job.find(params[:id])
    elsif params[:table] == 'failed_jobs'
      @job = FailedJob.find(params[:id])
    elsif params[:table] == 'completed_jobs'
      @job = CompletedJob.find(params[:id])
    end
    render :partial => '/admin/jobs/view_meta'
  end
  member_action :update_job, :method => :put do
    if params[:table] == 'jobs'
      @job = Job.find(params[:id])
    elsif params[:table] == 'failed_jobs'
      @job = FailedJob.find(params[:id])
    elsif params[:table] == 'completed_jobs'
      @job = CompletedJob.find(params[:id])
    end
    [:name, :data_generator, :status, :status_message, :position].each do |em|
      @job[em] = params[em]
    end
    if params[:wait] == 'true'
      @job.wait = 1
    else
      @job.wait = nil
    end
    if @job.save
      render json: true
    else
      render json: false
    end
  end
  member_action :delete_job, :method => :delete do
    job = Job.find(params[:id])
    if job.delete
      render json: true
    else
      render json: false
    end
  end
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
