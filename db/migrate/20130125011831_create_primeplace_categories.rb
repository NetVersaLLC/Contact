class CreatePrimeplaceCategories < ActiveRecord::Migration
  def change
    create_table :primeplace_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :primeplace_categories, :parent_id
    add_index :primeplace_categories, :name
    unless column_exists? :google_categories, :primeplace_category_id
      add_column :google_categories, :primeplace_category_id, :integer
    end
  end
end
