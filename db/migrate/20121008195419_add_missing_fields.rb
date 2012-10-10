class AddMissingFields < ActiveRecord::Migration
  def change
    add_column :businesses, :contact_birthday, :date
  end
end
