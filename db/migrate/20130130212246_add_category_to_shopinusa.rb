class AddCategoryToShopinusa < ActiveRecord::Migration
  def change
    add_column :shopinusas, :shopinusa_category_id, :integer
  end
end
