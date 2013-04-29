class CreateZiplocalCategories < ActiveRecord::Migration
  def change
    create_table :ziplocal_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :ziplocal_categories, :parent_id
    add_index :ziplocal_categories, :name
    unless column_exists? :google_categories, :ziplocal_category_id
      add_column :google_categories, :ziplocal_category_id, :integer
    end    
    unless column_exists? :ziplocals, :ziplocal_category_id
      add_column :ziplocals, :ziplocal_category_id, :integer
    end
  end
end
