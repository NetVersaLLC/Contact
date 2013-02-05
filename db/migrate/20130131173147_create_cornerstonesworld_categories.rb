class CreateCornerstoneworldCategories < ActiveRecord::Migration
  def change
    create_table :cornerstonesworld_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
     add_index :cornerstonesworld_categories, :parent_id
    add_index :cornerstonesworld_categories, :name
    add_column :google_categories, :cornerstonesworld_category_id, :integer
    unless column_exists? :google_categories, :cornerstonesworld_category_id
      add_column :google_categories, :cornerstonesworld_category_id, :integer
    end
  end
end
