require File.dirname(__FILE__) + '/../spec_helper'

describe JobsController do
  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  describe "post #create" do
    it 'should create a job successfully' do
      business= FactoryGirl.create(:business)
      user = business.user
      site= FactoryGirl.create(:site)
      site_transition= FactoryGirl.create(:site_transition, site: site)
      FactoryGirl.create(:business_site_state, business: business, site: site)
      params= {:site_id => site.id, :event => site_transition.on, :auth_token => user.authentication_token}

      post(:create, params)
      change(Job, :count).by(1).should be_true
      JSON.parse(response.body)["id"].should == Job.first.id
    end
  end

  describe "post #next_job_payload" do
    it 'should update the current job payload and get the next job payloads successfully' do
      user= FactoryGirl.create(:user)
      st= FactoryGirl.create(:site_transition)
      job= FactoryGirl.create(:job, site_transition: st)
      params= {:job_payload_id => job.job_payloads.first.id, :result => true, :message => "succeed", :auth_token => user.authentication_token}
      post(:next_job_payload, params)

      change(JobPayload, :count).by(2).should be_true
      JSON.parse(response.body)["next_job_payload"]["id"].should == job.job_payloads.all[1].id
    end

    it 'should mark the job as finished if the final job payload has been executed successfully' do
      user= FactoryGirl.create(:user)
      st= FactoryGirl.create(:site_transition)
      job= FactoryGirl.create(:job, site_transition: st)
      FactoryGirl.create(:business_site_state, site: st.site, business: job.business)

      params= {:job_payload_id => job.job_payloads.last.id, :result => true, :message => "succeed", :auth_token => user.authentication_token}
      post(:next_job_payload, params)

      params[:job_payload_id]= JSON.parse(response.body)["next_job_payload"]["id"]
      post(:next_job_payload, params)

      params[:job_payload_id]= JSON.parse(response.body)["next_job_payload"]["id"]
      post(:next_job_payload, params)

      change(JobPayload, :count).by(4).should be_true
      JSON.parse(response.body)["result"].should == "finished"
      BusinessSiteState.find_by_business_id_and_site_id(job.business_id, st.site_id).state.should == "signup"
    end

  end

end