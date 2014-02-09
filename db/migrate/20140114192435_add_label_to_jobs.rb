class AddLabelToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :label_id, :integer 
    add_column :completed_jobs, :label_id, :integer 
    add_column :failed_jobs, :label_id, :integer 
  end
end
