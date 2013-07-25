class AddFoursquarePageToFoursquare < ActiveRecord::Migration
  def change
    add_column :foursquares, :foursquare_page, :string
  end
end
