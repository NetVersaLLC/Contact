class AddMailToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :mail_host,     :string
    add_column :businesses, :mail_port,     :integer
    add_column :businesses, :mail_username, :string
    add_column :businesses, :mail_password, :string
  end
end
