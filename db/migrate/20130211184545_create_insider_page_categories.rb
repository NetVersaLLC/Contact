class CreateInsiderPageCategories < ActiveRecord::Migration
  def change
    create_table :insider_page_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :insider_page_categories, :parent_id
    add_index :insider_page_categories, :name    
     unless column_exists? :google_categories, :insider_page_category_id
      add_column :google_categories, :insider_page_category_id, :integer
    end
    unless column_exists? :insider_pages, :insider_page_category_id
      add_column :insider_pages, :insider_page_category_id, :integer
    end
  end
end
