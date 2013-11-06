class AddPayloadIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :payload_id, :integer
    add_column :completed_jobs, :payload_id, :integer
    add_column :failed_jobs, :payload_id, :integer
    add_index :jobs, :payload_id
    add_index :completed_jobs, :payload_id
    add_index :failed_jobs, :payload_id
  end
end
