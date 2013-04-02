class CreateLocalpagesCategories < ActiveRecord::Migration
  def change
    create_table :localpages_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :localpages_categories, :parent_id
    add_index :localpages_categories, :name
     unless column_exists? :google_categories, :localpages_category_id
      add_column :google_categories, :localpages_category_id, :integer
    end    
    unless column_exists? :localpages, :localpages_category_id
      add_column :localpages, :localpages_category_id, :integer
  	end
  end
end
