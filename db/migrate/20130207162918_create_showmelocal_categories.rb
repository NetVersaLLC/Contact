class CreateShowmelocalCategories < ActiveRecord::Migration
  def change
    create_table :showmelocal_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :showmelocal_categories, :parent_id
    add_index :showmelocal_categories, :name
    unless column_exists? :google_categories, :showmelocal_category_id
      add_column :google_categories, :showmelocal_category_id, :integer
    end
    unless column_exists? :showmelocals, :showmelocal_category_id
      add_column :showmelocals, :showmelocal_category_id, :integer
    end
  end
end
