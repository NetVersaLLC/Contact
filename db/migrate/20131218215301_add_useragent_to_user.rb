class AddUseragentToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_user_agent, :string
  end
end
