class AddCountryToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :country, :string, :default => 'United States'
  end
end
