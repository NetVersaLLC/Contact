class CreateAdsolutionsypCategories < ActiveRecord::Migration
  def change
    create_table :adsolutionsyp_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :adsolutionsyp_categories, :parent_id
    add_index :adsolutionsyp_categories, :name
    unless column_exists? :google_categories, :adsolutionsyp_category_id
      add_column :google_categories, :adsolutionsyp_category_id, :integer
    end    
    unless column_exists? :adsolutionsyps, :adsolutionsyp_category_id
      add_column :adsolutionsyps, :adsolutionsyp_category_id, :integer
  	end
  end
end
