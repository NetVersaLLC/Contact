class AddCategoryIdToDigabusiness < ActiveRecord::Migration
  def change
    add_column :digabusinesses, :digabusiness_category_id, :integer
  end
end
