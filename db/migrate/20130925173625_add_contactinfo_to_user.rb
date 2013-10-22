class AddContactinfoToUser < ActiveRecord::Migration
  def change
  	add_column :users, :contact_gender, :string
  	add_column :users, :contact_prefix, :string
  	add_column :users, :contact_first_name, :string
  	add_column :users, :contact_middle_name, :string
  	add_column :users, :contact_last_name, :string 
  	add_column :users, :contact_date_of_birth, :date
  	add_column :users, :mobile_phone, :string 
  	add_column :users, :mobile_appears, :boolean, :default => false 
  end
end