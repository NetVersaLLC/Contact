require File.dirname(__FILE__) + '/../spec_helper'

describe ScanController do
  describe "GET #start" do

    before(:each) do
      FactoryGirl.create(:label, :domain => 'test.host', :label_domain => 'test.host')
      FactoryGirl.create(:location, :zip => 43652, :city => 'Toledo', :county => 'Lucas', :state => 'OH',
                                    :country => 'US', :latitude => 41.6509670000, :longitude => -83.5364850000,
                                    :metaphone => 'TLT')
      create_site_profiles
    end

    def sample_form_data
      {
          :name => '',
          :phone => '12341234',
          :zip => 43652,
          :email => '',
          :referrer_code => '',
          :package_id => ''
      }
    end

    it 'should start report generation when business data is provided' do
      get(:start, sample_form_data)
      response.should be_success
      Report.where(:status => 'started').count. == 1
    end

    it 'should show user friendly error when zip not found' do
      data = sample_form_data
      data['zip'] = '99999'
      get(:start, data)
      response.should be_success
    end
  end

  describe "GET #show" do
    it "should work without errors" do
      report = FactoryGirl.create(:report, :status => 'completed')
      get :show, :id => report.ident
      response.should be_success
    end
  end

  describe "POST #submit_feedback" do
    it "should not work when report id is not provided" do
      post :submit_feedback, :report_feedback => {:message => "i dont like it"}
      response.should_not be_success
    end

    it "should work when message and report ident data provided" do
      report = FactoryGirl.create(:report, :status => 'completed')
      post :submit_feedback, :report_ident => report.ident, :report_feedback => {:message => "i dont like it"}
      response.should be_success
    end
  end
end