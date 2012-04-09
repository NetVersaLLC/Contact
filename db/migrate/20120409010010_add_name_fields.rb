class AddNameFields < ActiveRecord::Migration
  def change
    add_column :businesses, :first_name, :string
    add_column :businesses, :last_name, :string
    add_column :businesses, :middle_initial, :string
  end
end
