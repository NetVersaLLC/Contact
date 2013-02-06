class CreateLocalizedbizCategories < ActiveRecord::Migration
  def change
    create_table :localizedbiz_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
     add_index :localizedbiz_categories, :parent_id
    add_index :localizedbiz_categories, :name
    
    unless column_exists? :google_categories, :localizedbiz_category_id
      add_column :google_categories, :localizedbiz_category_id, :integer
    end
    unless column_exists? :localizedbizs, :localizedbiz_category_id
      add_column :localizedbizs, :localizedbiz_category_id, :integer
    end
  end
end
