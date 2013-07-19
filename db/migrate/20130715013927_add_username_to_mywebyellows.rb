class AddUsernameToMywebyellows < ActiveRecord::Migration
  def change
    add_column :mywebyellows, :username, :string
  end
end
