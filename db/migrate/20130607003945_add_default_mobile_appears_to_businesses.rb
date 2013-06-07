class AddDefaultMobileAppearsToBusinesses < ActiveRecord::Migration
  def change
    change_column :businesses, :mobile_appears, :boolean, :default => false 
  end
end
