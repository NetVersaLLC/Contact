require File.dirname(__FILE__) + '/../spec_helper'

describe JobsController do
  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @business= FactoryGirl.create(:business)
    @user = @business.user
    @bing= FactoryGirl.create(:site, name: "Bing")
    @site= FactoryGirl.create(:site, name: "Private")
    @bing_payload= FactoryGirl.create(:payload, site: @bing, name: "Signup")
    @payload= FactoryGirl.create(:payload, site: @site, name: "Signup")
  end

  it 'should rerun it if client reported failure explicitly' do
    @job= FactoryGirl.create(:job, business: @business, name: "Private/Signup")
    params= {:id => @job.id, :status=> "failed", :message=> "The job failed", :auth_token => @user.authentication_token}
    post(:update, params)
    change(FailedJob, :count).from(0).to(1).should be_true
    Job.where(:name=> "Private/Signup").first.status.should == Job::TO_CODE[:new]
  end

  it 'should rerun it if job is stalled' do
    @job= FactoryGirl.create(:job, business: @business, name: "Private/Signup", waited_at: (Time.now - 2.hours))
    params= {:business_id => @business.id, :auth_token => @user.authentication_token}
    post(:index, params)
    change(FailedJob, :count).from(0).to(1).should be_true
    Job.where(:name=> "Private/Signup").first.status.should == Job::TO_CODE[:new]
  end

  it 'should pause the business after 3 retries of Bing/Signup' do
    FactoryGirl.create_list(:failed_job, 3, business: @business, name: "Bing/Signup")
    @job= FactoryGirl.create(:job, business: @business, name: "Bing/Signup")
    params= {:id => @job.id, :status=> "failed", :message=> "The job failed", :auth_token => @user.authentication_token}
    post(:update, params)
    change(FailedJob, :count).by(1).should be_true
    (Time.now - @business.reload.paused_at).should_not > 10.minutes
  end

  it 'should pause the payload after 3 retries' do
    FactoryGirl.create_list(:failed_job, 3, business: @business, name: "Private/Signup")
    @job= FactoryGirl.create(:job, business: @business, name: "Private/Signup")
    params= {:id => @job.id, :status=> "failed", :message=> "The job failed", :auth_token => @user.authentication_token}
    post(:update, params)
    change(FailedJob, :count).by(1).should be_true
    (Time.now - @payload.reload.paused_at).should_not > 10.minutes
  end
end
