class AddUsernameToByzlysts < ActiveRecord::Migration
  def change
    add_column :byzlysts, :username, :string
  end
end
