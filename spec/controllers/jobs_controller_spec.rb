require File.dirname(__FILE__) + '/../spec_helper'

describe JobsController do
  before(:each) do
      @business= FactoryGirl.create(:business)
      @user = @business.user
      @site= FactoryGirl.create(:site)
      @site_transition= FactoryGirl.create(:site_transition, site: @site)
      @bss= FactoryGirl.create(:business_site_state, business: @business, site: @site)
      @site_transition= SiteTransition.find_by_site_id_and_from(@site.id, @bss.state)
  end

  describe "post #create" do
    def sample_form_data
      { :site_id => @site.id, :event => @site_transition.on, :auth_token => @user.authentication_token }
    end

    it 'should create a job successfully' do
      post(:create, sample_form_data , {'ACCEPT' => 'application/json'})
      change(Job, :count).by(1).should be_true
    end
  end
end