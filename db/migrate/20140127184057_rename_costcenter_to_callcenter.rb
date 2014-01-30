class RenameCostcenterToCallcenter < ActiveRecord::Migration
  def up
    rename_table :cost_centers, :call_centers
    rename_column :users, :cost_center_id, :call_center_id 
  end

  def down
    rename_table :call_centers, :cost_centers
    rename_column :users, :call_center_id, :cost_center_id
  end
end
