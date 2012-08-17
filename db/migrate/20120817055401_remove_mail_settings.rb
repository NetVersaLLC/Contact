class RemoveMailSettings < ActiveRecord::Migration
  def change
    remove_column :businesses, :mail_host
    remove_column :businesses, :mail_port
    remove_column :businesses, :mail_username
    remove_column :businesses, :mail_pass
    remove_column :businesses, :mail_type
  end
end
