class CreateFindthebestCategories < ActiveRecord::Migration
  def change
    create_table :findthebest_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :findthebest_categories, :parent_id
    add_index :findthebest_categories, :name
    unless column_exists? :google_categories, :findthebest_category_id
      add_column :google_categories, :findthebest_category_id, :integer
    end    
    unless column_exists? :findthebests, :findthebest_category_id
      add_column :findthebests, :findthebest_category_id, :integer
  	end
  end
end
