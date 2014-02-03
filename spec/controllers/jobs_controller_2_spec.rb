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

  # this simulates the citation client making calls against the jobs controller 
  # to get work to do, and update what happened.  
  it 'should insert the rest of the jobs when the bing sign up succeeds' do 
    create(:payload, site: @bing, name: "SignUp", to_mode_id: 1)
    create(:payload, site: @site, name: "DoSomething", to_mode_id: 1, mode_id: 2)
    create(:package_payload, package_id: 1, site_id: @site.id)
    
    b = create(:business, categorized: true)
    Task.request_sync( b )

    get :index, {:business_id => b.id, :auth_token => b.user.authentication_token}
    expect(response.body).to eq('{"status":"wait"}')

    get :index, {:business_id => b.id, :auth_token => b.user.authentication_token}
    job = JSON.parse(response.body)
    expect(job["name"]).to eq("Bing/SignUp") 

    put :update, {id: job["id"], status: 'success', message: 'all is good'}
    expect(CompletedJob.first.name).to eq("Bing/SignUp")

    get :index, {:business_id => b.id, :auth_token => b.user.authentication_token}
    expect(response.body).to eq('{"status":"wait"}')

    get :index, {:business_id => b.id, :auth_token => b.user.authentication_token}
    job = JSON.parse(response.body)
    expect(job["name"]).to eq("Private/DoSomething") 

    put :update, {id: job["id"], status: 'success', message: 'all is good'}
    expect(CompletedJob.last.name).to eq("Private/DoSomething")

  end 


end

