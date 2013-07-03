class CreateYellowtalkCategories < ActiveRecord::Migration
  def change
    create_table :yellowtalk_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    #Code added by Coin --- Start
     add_index :yellowtalk_categories, :parent_id
    add_index :yellowtalk_categories, :name
  unless column_exists? :google_categories, :yellowtalk_category_id
  	add_column :google_categories, :yellowtalk_category_id, :integer
 	end
  #Code addition ends
end
end