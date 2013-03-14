class CreateFoursquareCategories < ActiveRecord::Migration
  def change
    create_table :foursquare_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :foursquare_categories, :parent_id
    add_index :foursquare_categories, :name
    
    unless column_exists? :google_categories, :foursquare_category_id
      add_column :google_categories, :foursquare_category_id, :integer
    end
    
    unless column_exists? :foursquares, :foursquare_category_id
      add_column :foursquares, :foursquare_category_id, :integer
  	end

  end
end
