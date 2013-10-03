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
      scan.reload
      scan.task_status.should eq Scan::TASK_STATUS_TAKEN
    end
  end

  describe 'format_data_for_server' do
    it 'should include id' do
      scan = FactoryGirl.create(:scan)
      data = scan.format_data_for_scan_server
      data[:scan].has_key?(:id).should == true
    end
  end

  describe 'resend_long_waiting_tasks!' do
    it 'should resend tasks that have been waiting for the response longer than X seconds' do
      scan = FactoryGirl.create(:scan,
        updated_at: DateTime.current - Contact::Application.config.scan_task_resend_interval - 1.minute,
        task_status: Scan::TASK_STATUS_TAKEN)
      delayed_jobs_before_operation = DelayedJob.all.size
      Scan.resend_long_waiting_tasks!
      DelayedJob.all.size.should > delayed_jobs_before_operation
    end
  end
end
