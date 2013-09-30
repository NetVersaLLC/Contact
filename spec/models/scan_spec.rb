require 'spec_helper'

# requires runing scanserver to pass
describe Scan do
  describe 'create_for_site' do
    before(:each) do
      create_site_profiles
      @report = FactoryGirl.create(:report)
      @location = FactoryGirl.create(:location)
    end

    it 'should create valid scan task' do
      site = 'Foursquare'
      scan = Scan.create_for_site(@report.id, site)
      scan.task_status.should eq Scan::TASK_STATUS_WAITING
      scan.report_id.should eq @report.id
      scan.site.should eq site
    end
  end

  describe 'send_to_scan_server!' do
    it 'should send task to scan server without errors' do
      scan = FactoryGirl.create(:scan)
      response, status, error_message = scan.send_to_scan_server!
      error_message.should eq nil
    end
  end

  describe 'format_data_for_server' do
    it 'should include id' do
      scan = FactoryGirl.create(:scan)
      data = scan.format_data_for_scan_server
      parsed = JSON.parse(data[:scan])
      JSON.parse(data[:scan]).has_key?('id').should == true
    end
  end
end
