class CreateHyploCategories < ActiveRecord::Migration
  def change
    create_table :hyplo_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :hyplo_categories, :parent_id
    add_index :hyplo_categories, :name
    unless column_exists? :google_categories, :hyplo_category_id
      add_column :google_categories, :hyplo_category_id, :integer
    end
    unless column_exists? :hyplos, :hyplo_category_id
      add_column :hyplos, :hyplo_category_id, :integer
    end
  end
end
