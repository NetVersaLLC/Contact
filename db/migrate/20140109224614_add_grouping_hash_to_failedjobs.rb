class AddGroupingHashToFailedjobs < ActiveRecord::Migration
  def change
    add_column :failed_jobs, :grouping_hash, :string
    add_index :failed_jobs, :grouping_hash
  end
end
