class AddCategoryIdToYellowee < ActiveRecord::Migration
  def change
    add_column :yellowees, :yellowee_category_id, :integer
  end
end
