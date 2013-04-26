class CreateMojopagesCategories < ActiveRecord::Migration
  def change
    create_table :mojopages_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :mojopages_categories, :parent_id
    add_index :mojopages_categories, :name
    unless column_exists? :google_categories, :mojopages_category_id
      add_column :google_categories, :mojopages_category_id, :integer
    end    
    unless column_exists? :mojopages, :mojopages_category_id
      add_column :mojopages, :mojopages_category_id, :integer
  	end
  end
end
