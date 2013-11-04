require 'spec_helper'

describe Report do

  describe 'updated_statuses' do
    it 'should mark report as completed when the last scan is finished' do
      report = FactoryGirl.create(:report, :status => 'started')
      FactoryGirl.create(:scan, :report_id => report.id, :task_status => Scan::TASK_STATUS_FINISHED)
      FactoryGirl.create(:scan, :report_id => report.id, :task_status => Scan::TASK_STATUS_FAILED)
      Report.update_statuses
      report.reload
      report.status.should == 'completed'
      report.completed_at.should > Time.now - 1.minute
    end

    it 'should not mark report as completed until all tasks are finished' do
      report = FactoryGirl.create(:report, :status => 'started')
      FactoryGirl.create(:scan, :report_id => report.id, :task_status => Scan::TASK_STATUS_FINISHED)
      FactoryGirl.create(:scan, :report_id => report.id, :task_status => Scan::TASK_STATUS_WAITING)
      Report.update_statuses
      report.reload
      report.status.should == 'started'
      report.completed_at.should == nil
    end
  end

  describe 'create_scan_tasks' do
    it 'should create delayed job for each task' do
      report = FactoryGirl.create(:report, status: 'waiting')
      FactoryGirl.create(:location)
      create_site_profiles

      report.create_scan_tasks
      DelayedJob.all.size.should > 0
    end
  end

  describe 'relaunch' do
    it 'should relaunch report generation ' do
      report = FactoryGirl.create(:report, status: 'completed')
      scan = FactoryGirl.create(:scan, task_status:3, report_id: report.id)
      report.relaunch!
      report.reload
      report.status.should == 'started'
      report.scans.size.should > 10
    end
  end
end
