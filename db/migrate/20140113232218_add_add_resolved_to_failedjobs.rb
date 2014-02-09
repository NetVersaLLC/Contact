class AddAddResolvedToFailedjobs < ActiveRecord::Migration
  def change
    add_column :failed_jobs, :resolved, :boolean, :default => false
  end
end
