class AddUsernameToBusinesscom < ActiveRecord::Migration
  def change
    add_column :businesscoms, :username, :string
  end
end
