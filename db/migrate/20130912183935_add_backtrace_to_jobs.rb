class AddBacktraceToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :backtrace, :text
  end
end
