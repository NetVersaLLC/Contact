class ManagerReferencesCostcenter < ActiveRecord::Migration
  def change
    add_column :users, :cost_center_id, :integer, index: true
  end
end
