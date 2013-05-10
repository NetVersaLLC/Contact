class CreateBusinessdbCategories < ActiveRecord::Migration
  def change
    create_table :businessdb_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :businessdb_categories, :parent_id
    add_index :businessdb_categories, :name
    unless column_exists? :google_categories, :businessdb_category_id
      add_column :google_categories, :businessdb_category_id, :integer
    end    
    unless column_exists? :businessdbs, :businessdb_category_id
      add_column :businessdbs, :businessdb_category_id, :integer
  	end
  end
end
