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
      site = FactoryGirl.create(:site, name: 'Foursquare')
      scan = Scan.create_for_site(@report.id, site)
      scan.task_status.should eq Scan::TASK_STATUS_WAITING
      scan.report_id.should eq @report.id
      scan.site_name.should eq site.name
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

    it 'should mark task as failed immediately when got error from scanserver' do
      scan = FactoryGirl.create(:scan, :site_name => 'nosuchsite')
      scan.send_to_scan_server!
      scan.reload
      scan.task_status.should == Scan::TASK_STATUS_FAILED
    end

    it 'should not mark task as failed when scanserver is down (connection refused)' do
      scan = FactoryGirl.create(:scan)
      scan_server_uri = Contact::Application.config.scanserver['server_uri']
      Contact::Application.config.scanserver['server_uri'] = 'http://localhost:4565/';
      scan.send_to_scan_server!
      Contact::Application.config.scanserver['server_uri'] = scan_server_uri
      scan.reload
      scan.task_status.should == Scan::TASK_STATUS_WAITING
    end
  end

  describe 'send_all_waiting_tasks!' do
    self.use_transactional_fixtures = false

    it 'should send all tasks in WAITING status to scan server' do
      scan = FactoryGirl.create(:scan)
      Scan.send_all_waiting_tasks!
      sleep(2) # easy way to avoid dealing with thread monitoring. May fail in rare cases.
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
      threads_before_operation = Thread.list.size
      Scan.resend_long_waiting_tasks!
      Thread.list.size > threads_before_operation # may fail sometimes
    end
  end

  describe 'fail_tasks_that_waiting_too_long!' do
    it 'should mark as failed tasks that didnt get result in reasonable time' do
      scan = FactoryGirl.create(:scan,
                                created_at: DateTime.current - Contact::Application.config.scan_task_fail_interval - 1.second,
                                task_status: Scan::TASK_STATUS_TAKEN)
      Scan.fail_tasks_that_waiting_too_long!
      scan.reload
      scan.task_status.should == Scan::TASK_STATUS_FAILED
    end
  end
end
