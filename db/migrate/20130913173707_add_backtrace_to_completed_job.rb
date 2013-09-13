class AddBacktraceToCompletedJob < ActiveRecord::Migration
  def change
    add_column :completed_jobs, :backtrace, :text
    add_column :completed_jobs, :screenshot_id, :integer
  end
end
