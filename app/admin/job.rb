ActiveAdmin.register Job do
  index do
    column :business_id
    column :name
    column :model
    column :status
    column :created_at
    column :waited_at
    default_actions
  end

  collection_action :pending_jobs, :method => :get do
    @jobs = Job.where('business_id = ? AND status IN (0,1)', params[:business_id])
    render json: @jobs
  end
  collection_action :failed_jobs, :method => :get do
    @jobs = FailedJob.where('business_id = ?', params[:business_id])
    render json: @jobs
  end
  collection_action :completed_jobs, :method => :get do
    @jobs = CompletedJob.where('business_id = ?', params[:business_id])
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
    [:name, :model, :status, :status_message, :position].each do |em|
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
    payload = Payload.find(params[:id])
    job = Job.inject(params[:business_id], payload.payload, payload.model)
    job.name = payload.name
    job.save
    render json: true
  end
end
