class AddCategorized < ActiveRecord::Migration
  def change
    add_column :businesses, :categorized, :boolean
  end
end
