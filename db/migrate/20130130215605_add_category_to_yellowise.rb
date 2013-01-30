class AddCategoryToYellowise < ActiveRecord::Migration
  def change
    add_column :yellowises, :yellowise_category_id, :integer
  end
end
