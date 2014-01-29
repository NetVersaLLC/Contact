require File.dirname(__FILE__) + '/../spec_helper'

describe JobsController do
  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @business= FactoryGirl.create(:business)
    @user = @business.user
    @bing= FactoryGirl.create(:site, name: "Bing")
    @site= FactoryGirl.create(:site, name: "Private")
    @payload= FactoryGirl.create(:payload_chain, site: @site)
    @bing_payload= FactoryGirl.create(:payload, site: @bing, name: "Signup")
    FactoryGirl.create(:business_site_mode, business: @business, site: @site, mode: Mode.first)
  end

  #it 'should rerun it if client reported failure explicitly' do
  #  @job= FactoryGirl.create(:job, business: @business, name: "Private/Signup")
  #  params= {:id => @job.id, :status=> "failed", :message=> "The job failed", :auth_token => @user.authentication_token}
  #  post(:update, params)
  #  change(FailedJob, :count).from(0).to(1).should be_true
  #  Job.where(:name=> "Private/Signup").first.status.should == Job::TO_CODE[:new]
  #end

  it 'should rerun it if job is stalled' do
    @job= FactoryGirl.create(:job, business: @business, name: "Private/Signup", waited_at: (Time.now - 2.hours))
    params= {:business_id => @business.id, :auth_token => @user.authentication_token}
    post(:index, params)
    change(FailedJob, :count).from(0).to(1).should be_true
    Job.where(:name=> "Private/Signup").first.status.should == Job::TO_CODE[:new]
  end

  it 'should pause the business after 3 retries of Bing/Signup' do
    FactoryGirl.create_list(:failed_job, 3, business: @business, name: "Bing/SignUp")
    @job= FactoryGirl.create(:job, business: @business, name: "Bing/SignUp")
    params= {:id => @job.id, :status=> "failed", :message=> "The job failed", :auth_token => @user.authentication_token}
    post(:update, params)
    change(FailedJob, :count).by(1).should be_true
    (Time.now - @business.reload.paused_at).should_not > 10.minutes
  end

  #it 'should pause the payload after 3 retries' do
  #  jobname= "#{@site.name}/#{@payload.name}"
  #  FactoryGirl.create_list(:failed_job, 3, business: @business, name: jobname)
  #  @job= FactoryGirl.create(:job, business: @business, name: jobname)
  #  params= {:id => @job.id, :status=> "failed", :message=> "The job failed", :auth_token => @user.authentication_token}
  #  post(:update, params)
  #  change(FailedJob, :count).by(1).should be_true
  #  (Time.now - Payload.by_name(jobname).reload.paused_at).should_not > 10.minutes
  #end

  it 'should update the mode of website when reaching a leaf in the tree' do
    cjob1= FactoryGirl.create(:completed_job, name: "#{@site.name}/#{@payload.name}", business: @business)
    cjob2= FactoryGirl.create(:completed_job, name: "#{@site.name}/#{@payload.children.first.name}",
                               business: @business, parent_id: cjob1.id)
    new_job= FactoryGirl.create(:job, name: "#{@site.name}/#{@payload.children.first.children.first.name}",
                                 business: @business, parent_id: cjob2.id)
    params= {:business_id => @business.id, :id=> new_job.id, :status=> "success", :auth_token => @user.authentication_token}
    post(:update, params)
    BusinessSiteMode.first.mode_id.should == @payload.children.first.children.first.to_mode_id
  end

  it 'should set the previous job as the parent of current job if their payloads has that relationship' do
    # Create a list of completed jobs and ensure that the latest completed job would be considered as parent
    @completed_jobs= FactoryGirl.create_list(:completed_job, 2, name: "#{@site.name}/#{@payload.name}", business: @business)
    params= {:business_id => @business.id, :name=> "#{@site.name}/#{@payload.children.first.name}", :auth_token => @user.authentication_token}
    post(:create, params)
    JSON.parse(response.body)["parent_id"].should == @completed_jobs[1].id
  end

  it 'should respond with NO_CATEGORUES if the business is not categorized' do 
    b = create(:business, categorized: false)
    get :index, {:business_id => b.id, :auth_token => b.user.authentication_token}

    expect(response.body).to eq('{"status":"no_categories"}')
  end 

  it 'should respond with PAUSED if the business is invalid' do 
    b = create(:business)
    b.mobile_phone = nil
    b.save validate: false 

    get :index, {:business_id => b.id, :auth_token => b.user.authentication_token}

    expect(response.body).to eq('{"status":"paused"}')
  end 

  it 'should respond with WAIT when there is nothing to do' do 
    b = create(:business, categorized: true)
    get :index, {:business_id => b.id, :auth_token => b.user.authentication_token}

    expect(response.body).to eq('{"status":"wait"}')
  end 

  it 'should only insert Bing/SignUp on the first sync' do
    b = create(:business, categorized: true)
    Task.request_sync( b )

    get :index, {:business_id => b.id, :auth_token => b.user.authentication_token}

    expect(response.body).to eq('{"status":"wait"}')
    expect(Job.all.count).to eq(1) 
    expect(Job.first.name).to eq("Bing/SignUp") 
  end 

  it 'should switch from CREATE mode to UPDATE mode after a listing was created' do 
    # RestClient.post("#{@host}/jobs.json?auth_token=#{@key}&business_id=#{@bid}", :message => msg, :name => name, :delay => time_delay, :version => @version)
    # RestClient.put("#{@host}/jobs/#{@job['id']}.json?auth_token=#{@key}&business_id=#{@bid}", :status => 'success', :message => msg, :version => @version)

    b = create(:business, categorized: true)

    post :create, {:business_id => b.id, :auth_token => b.user.authentication_token, :name => 'Bing/CreateListing'}

    get  :index, {:business_id => b.id, :auth_token => b.user.authentication_token}
    job = JSON.parse( response.body ) 

    put  :update, :id => job.id, :business_id => b.id, :auth_token => b.user.authentication_token, status: 'success', message: 'message' 

    expect(BusinessSiteMode.where(:business_id => b.id).first.mode_id).to eq(3)
  end 


end
