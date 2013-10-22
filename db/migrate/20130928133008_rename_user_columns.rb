class RenameUserColumns < ActiveRecord::Migration
  def change
    rename_column :users, :contact_gender, :gender
    rename_column :users, :contact_prefix, :prefix
    rename_column :users, :contact_first_name, :first_name
    rename_column :users, :contact_middle_name, :middle_name
    rename_column :users, :contact_last_name, :last_name
    rename_column :users, :contact_date_of_birth, :date_of_birth
  end
end
