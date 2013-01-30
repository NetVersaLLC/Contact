class AddCategoryToYellowassistance < ActiveRecord::Migration
  def change
    add_column :yellowassistances, :yellowassistance_category_id, :integer
  end
end
