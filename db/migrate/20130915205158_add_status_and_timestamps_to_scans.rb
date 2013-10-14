class AddStatusAndTimestampsToScans < ActiveRecord::Migration
  def change
    add_column :scans, :created_at, :datetime
    add_column :scans, :updated_at, :datetime
    add_column :scans, :task_status, :integer
  end
end
