class CreateSpotbusinessCategories < ActiveRecord::Migration
  def change
    create_table :spotbusiness_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :spotbusiness_categories, :parent_id
    add_index :spotbusiness_categories, :name
     unless column_exists? :google_categories, :spotbusiness_category_id
      add_column :google_categories, :spotbusiness_category_id, :integer
    end    
    unless column_exists? :spotbusinesses, :spotbusiness_category_id
      add_column :spotbusinesses, :spotbusiness_category_id, :integer
  	end
  end
end
