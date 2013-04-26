class CreateLocaldatabaseCategories < ActiveRecord::Migration
  def change
    create_table :localdatabase_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :localdatabase_categories, :parent_id
    add_index :localdatabase_categories, :name
     unless column_exists? :google_categories, :localdatabase_category_id
      add_column :google_categories, :localdatabase_category_id, :integer
    end    
    unless column_exists? :localdatabases, :localdatabase_category_id
      add_column :localdatabases, :localdatabase_category_id, :integer
  	end
  end
end
