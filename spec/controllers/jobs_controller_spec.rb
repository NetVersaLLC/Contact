require File.dirname(__FILE__) + '/../spec_helper'

describe JobsController do
  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @business= FactoryGirl.create(:business)
    @user = @business.user
    @site= FactoryGirl.create(:site)
    current_mode= FactoryGirl.create(:business_site_mode, site: @site, business: @business)
    @payload= FactoryGirl.create(:payload_chain, site: @site)
  end

  describe "post #create" do
    it 'should create a job successfully' do
      params= {:business_id => @business.id, :name=> "#{@site.name}/#{@payload.name}", :auth_token => @user.authentication_token}
      post(:create, params)
      change(Job, :count).by(1).should be_true
      JSON.parse(response.body)["id"].should == Job.first.id
    end
  end

  describe "post #update" do
    it 'should update the current job and move it to CompleteJob table when successfull' do
      @job= FactoryGirl.create(:job, business: @business)
      params= {:id => @job.id, :status=> "success", :message=> "The job was successfull", :auth_token => @user.authentication_token}
      post(:update, params)
      change(CompletedJob, :count).by(1).should be_true
      response.code.should == '204'
    end

    it 'should update the current job and move it to FailedJob table when failed 2 times' do
      @job= FactoryGirl.create(:job, business: @business)
      params= {:id => @job.id, :status=> "failed", :message=> "The job was failed",
               :backtrace=> "this is a backtrace",
               :auth_token => @user.authentication_token}
      post(:update, params)
      change(FailedJob, :count).by(0).should be_true
      post(:update, params)
      change(FailedJob, :count).by(1).should be_true
      response.code.should == '204'
    end
  end

  describe "get #index" do
    it 'should rerun the job after a configure interval' do
      @job= FactoryGirl.create(:job,  backtrace: "this is the first backtrace",
                               business: @business, status: Job::TO_CODE[:new], retries: 1,
                               waited_at: Time.current-10.minutes, runtime: Time.current-10.minutes)
      params= { :business_id=> @business.id, :auth_token => @user.authentication_token}
      get(:index, params)
      @new_job= JSON.parse(response.body)
      @new_job["id"].should == @job.id
    end

    it 'should set the previous job as the parent of current job if their payloads has that relationship' do
      # Create a list of completed jobs and ensure that the latest completed job would be considered as parent
      @completed_jobs= FactoryGirl.create_list(:completed_job,2, name: "#{@site.name}/#{@payload.name}", business: @business)
      params= {:business_id => @business.id, :name=> "#{@site.name}/#{@payload.children.first.name}", :auth_token => @user.authentication_token}
      post(:create, params)
      JSON.parse(response.body)["parent_id"].should == @completed_jobs[1].id
    end
  end
end