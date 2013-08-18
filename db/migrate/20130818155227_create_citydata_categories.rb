class CreateCitydataCategories < ActiveRecord::Migration
  def change
    create_table :citydata_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :citydata_categories, :parent_id
    add_index :citydata_categories, :name
    unless column_exists? :google_categories, :citydata_category_id
      add_column :google_categories, :citydata_category_id, :integer
    end    
    #unless column_exists? :citydatas, :citydata_category_id
    #  add_column :citydatas, :citydata_category_id, :integer
  	#end
  end
end
