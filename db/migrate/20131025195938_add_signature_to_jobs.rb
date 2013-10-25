class AddSignatureToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :signature, :text
    add_column :completed_jobs, :signature, :text
    add_column :failed_jobs, :signature, :text
    add_column :payloads, :signature, :text
  end
end
