class AddRoleHierarchies < ActiveRecord::Migration
  def change
    add_column :users, :manager_id,  :integer 
    add_column :users, :reseller_id, :integer
    add_column :businesses, :sales_person_id, :integer
  end
end
