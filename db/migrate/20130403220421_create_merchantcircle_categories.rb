class CreateMerchantcircleCategories < ActiveRecord::Migration
  def change
    create_table :merchantcircle_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :merchantcircle_categories, :parent_id
    add_index :merchantcircle_categories, :name
    unless column_exists? :google_categories, :merchantcircle_category_id
      add_column :google_categories, :merchantcircle_category_id, :integer
    end    
    unless column_exists? :merchantcircles, :merchantcircle_category_id
      add_column :merchantcircles, :merchantcircle_category_id, :integer
  	end
  end
end
