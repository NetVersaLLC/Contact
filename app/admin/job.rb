ActiveAdmin.register Job do
  scope_to :current_user, :association_method => :job_scope
  index do
    column :business_id
    column :name
    column :status
    column :created_at
    column :waited_at
    default_actions
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
    respond_to do |format|
      format.html { render "results", layout: false }
      format.json { render json: @jobs }
    end 
  end

  collection_action :failed_jobs, :method => :get do
    @jobs = FailedJob.where('business_id = ?', params[:business_id]).order(:position)
    respond_to do |format|
      format.html { render "results", layout: false }
      format.json { render json: @jobs }
    end 
  end

  collection_action :completed_jobs, :method => :get do
    @jobs = CompletedJob.where('business_id = ?', params[:business_id]).order(:position)
    respond_to do |format|
      format.html { render "results", layout: false }  
      format.json { render json: @jobs }  
    end 
  end

  collection_action :latest_jobs, :method => :get do
    @jobs = []
    business = Business.find(params[:business_id]) 
    sites = business.subscription.package.package_payloads.pluck(:site)

    PayloadNode.order('position asc').each do |node| 
      next unless sites.include?( node.name.split('/')[0])

      job = Job.get_latest( business, node.name) 
      job = Job.new( name: node.name, status: 6 ) if job.nil? # missing job 
      @jobs.push job
    end 

    respond_to do |format|
      format.html { render "results", layout: false }  
      format.json { render json: @jobs }  
    end 
  end

  member_action :view_payload, :method => :get do
    @job = Job.get(params[:table], params[:id])
    render :inline => CodeRay.scan(@job.payload, :ruby).page
  end

  member_action :view_backtrace, :method => :get do
    @job = FailedJob.find(params[:id])
    render :partial => 'view_backtrace'
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

  member_action :create_job, :method => :post do
    payload = Payload.new( params[:category], params[:id] )
    job = Job.inject(params[:business_id], payload.payload, payload.data_generator, payload.ready)
    job.name = "#{params[:category]}/#{params[:id]}"
    job.save
    render json: true
  end

  collection_action :toggle_jobs, :method => :put do
    business = Business.find(params[:business_id])
    paused = nil
    if business.paused_at == nil
      business.paused_at = Time.now
      paused = true
    else
      business.paused_at = nil
      paused = false
    end
    business.save
    render json: paused
  end

  collection_action :add_missing, :method => :post do
    business = Business.find(params[:business_id])
    PayloadNode.add_missed_payloads(business)
    render json: true
  end

  collection_action :clear_jobs, :method => :delete do
    Job.delete_all(:business_id => params[:business_id])
    render json: true
  end

  member_action :reorder, :method => :post do
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
