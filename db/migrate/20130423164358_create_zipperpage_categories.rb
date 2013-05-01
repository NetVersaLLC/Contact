class CreateZipperpageCategories < ActiveRecord::Migration
  def change
    create_table :zipperpage_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :zipperpage_categories, :parent_id
    add_index :zipperpage_categories, :name
    unless column_exists? :google_categories, :zipperpage_category_id
      add_column :google_categories, :zipperpage_category_id, :integer
    end
    unless column_exists? :zipperpages, :zipperpage_category_id
      add_column :zipperpages, :zipperpage_category_id, :integer
    end
  end
end
