class CreateMeetlocalbizCategories < ActiveRecord::Migration
  def change
    create_table :meetlocalbiz_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :meetlocalbiz_categories, :parent_id
    add_index :meetlocalbiz_categories, :name
    unless column_exists? :google_categories, :meetlocalbiza_category_id
      add_column :google_categories, :meetlocalbiz_category_id, :integer
    end    
    unless column_exists? :meetlocalbizs, :meetlocalbiz_category_id
      add_column :meetlocalbizs, :meetlocalbiz_category_id, :integer
  	end
  end
end
