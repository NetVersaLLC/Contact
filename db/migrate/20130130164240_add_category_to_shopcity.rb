class AddCategoryToShopcity < ActiveRecord::Migration
  def change
    add_column :shopcities, :shopcity_category_id, :integer
  end
end
