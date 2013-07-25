class AddCategoryIdToYellowtalks < ActiveRecord::Migration
  def change
    add_column :yellowtalks, :yellowtalk_category_id, :integer
  end
end
