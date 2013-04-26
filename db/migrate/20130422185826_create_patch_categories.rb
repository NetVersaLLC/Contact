class CreatePatchCategories < ActiveRecord::Migration
  def change
    create_table :patch_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :patch_categories, :parent_id
    add_index :patch_categories, :name
    unless column_exists? :google_categories, :patch_category_id
      add_column :google_categories, :patch_category_id, :integer
    end    
    unless column_exists? :patches, :patch_category_id
      add_column :patches, :patch_category_id, :integer
    end
  end
end
