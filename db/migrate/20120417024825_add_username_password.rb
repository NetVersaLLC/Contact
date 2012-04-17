class AddUsernamePassword < ActiveRecord::Migration
  def change
    add_column :businesses, :yelp_email, :string
    add_column :businesses, :yelp_password, :string
  end
end
