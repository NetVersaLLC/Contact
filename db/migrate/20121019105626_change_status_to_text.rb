class ChangeStatusToText < ActiveRecord::Migration
  def change
    change_column :jobs, :status_message, :text
    change_column :completed_jobs, :status_message, :text
    change_column :failed_jobs, :status_message, :text
  end
end
