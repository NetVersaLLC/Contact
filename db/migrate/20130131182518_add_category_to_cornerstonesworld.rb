class AddCategoryToCornerstonesworld < ActiveRecord::Migration
  def change
    add_column :cornerstonesworlds, :cornerstonesworld_category_id, :integer
  end
end
