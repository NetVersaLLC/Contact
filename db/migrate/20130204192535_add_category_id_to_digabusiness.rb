class AddCategoryIdToDigabusiness < ActiveRecord::Migration
  def change
    add_column :digabusinesses, :yellowee_category_id, :integer
  end
end
