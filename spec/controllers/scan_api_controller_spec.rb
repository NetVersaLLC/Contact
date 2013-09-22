require File.dirname(__FILE__) + '/../spec_helper'

describe ScanApiController do
  describe "GET #submit_scan_result" do

    def sample_scan_data(id)
      {
          :id => id,
          :listed_phone => '12341234',
          :listed_address => '123 Avenue',
          :listed_url => 'http://tr.im/4fdzs',
          :status => 'listed'
      }
    end

    it 'should fail when given invalid authentication token' do
      get :submit_scan_result, :token => 'abc'
      response.status.should == 403
    end

    it 'should update task status' do
      scan = FactoryGirl.create(:scan, :task_status => Scan::TASK_STATUS_TAKEN)
      sample_data = sample_scan_data(scan.id)
      get :submit_scan_result, :token => '892457gh9q87fah98ef7hq987harhq9w87eh8', :scan => sample_data
      response.should be_success
      scan.reload
      scan.task_status.should == Scan::TASK_STATUS_FINISHED
      scan.listed_phone.should == sample_data[:listed_phone]
      scan.listed_address.should == sample_data[:listed_address]
      scan.listed_url.should == sample_data[:listed_url]
      scan.status.should == 'listed'
    end

    it 'should fail when task status is not TAKEN' do
      scan = FactoryGirl.create(:scan, :task_status => Scan::TASK_STATUS_WAITING)
      sample_data = sample_scan_data(scan.id)
      get :submit_scan_result, :token => '892457gh9q87fah98ef7hq987harhq9w87eh8', :scan => sample_data
      response.should_not be_success
    end
  end
end