class AddCitisquareCategoryid < ActiveRecord::Migration
  def change
    add_column :citisquares, :citisquare_category_id, :integer
    add_index :citisquares, :citisquare_category_id
  end
end
