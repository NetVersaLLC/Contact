class AddUserLevelToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :admin, :boolean, :default => false
    add_column :admin_users, :label_id, :integer, :default => 1
    add_index  :admin_users,  :label_id
  end
end
