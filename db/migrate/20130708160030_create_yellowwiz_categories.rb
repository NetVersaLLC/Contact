class CreateYellowwizCategories < ActiveRecord::Migration
  def change
    create_table :yellowwiz_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :yellowwiz_categories, :parent_id
  #Code added by Coin --- Start
    add_index :yellowwiz_categories, :name
  	unless column_exists? :google_categories, :yellowwiz_category_id
  	   add_column :google_categories, :yellowwiz_category_id, :integer
 	  end
  #Code addition ends    
  end
end
