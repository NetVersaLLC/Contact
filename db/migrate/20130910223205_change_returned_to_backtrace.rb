class ChangeReturnedToBacktrace < ActiveRecord::Migration
  def change
    remove_column :jobs, :returned
    remove_column :completed_jobs, :returned
    rename_column :failed_jobs, :returned, :backtrace
    add_column :failed_jobs, :screenshot_id, :integer
    add_index :failed_jobs, :screenshot_id
  end
end
