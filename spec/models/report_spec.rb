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

end
