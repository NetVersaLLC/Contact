class AddBizhywCategories < ActiveRecord::Migration
  def change
    add_column :google_categories, :bizhyw_category_id, :integer
    create_table :bizhyw_categories do |t|
      t.string :name
      t.integer :parent_id
    end
  end
end
