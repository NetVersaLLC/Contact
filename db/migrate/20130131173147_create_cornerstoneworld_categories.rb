class CreateCornerstoneworldCategories < ActiveRecord::Migration
  def change
    create_table :cornerstoneworld_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
     add_index :cornerstoneworld_categories, :parent_id
    add_index :cornerstoneworld_categories, :name
    add_column :google_categories, :cornerstoneworld_category_id, :integer
    unless column_exists? :primeplaces, :primeplace_category_id
      add_column :cornerstoneworld, :cornerstoneworld_category_id, :integer
    end
  end
end
