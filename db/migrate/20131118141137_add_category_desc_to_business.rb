class AddCategoryDescToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :category_description, :string
  end
end
