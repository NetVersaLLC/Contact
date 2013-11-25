class CreateBigwigbizCategories < ActiveRecord::Migration
  def change
    create_table :bigwigbiz_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    add_column :google_categories, :bigwigbiz_category_id, :integer
  end
end
