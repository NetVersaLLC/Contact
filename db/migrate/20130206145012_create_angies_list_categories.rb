class CreateAngiesListCategories < ActiveRecord::Migration
  def change
    create_table :angies_list_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
     add_index :angies_list_categories, :parent_id
    add_index :angies_list_categories, :name
    
    unless column_exists? :google_categories, :angies_list_category_id
      add_column :google_categories, :angies_list_category_id, :integer
    end
    unless column_exists? :angies_lists, :angies_list_category_id
      add_column :angies_lists, :angies_list_category_id, :integer
    end
  end
end
