class AddUsernameToEbusinesspages < ActiveRecord::Migration
  def change
    add_column :ebusinesspages, :username, :string
  end
end
