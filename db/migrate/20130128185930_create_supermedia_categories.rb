class CreateSupermediaCategories < ActiveRecord::Migration
  def change
    create_table :supermedia_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :supermedia_categories, :parent_id
    add_index :supermedia_categories, :name
    add_column :google_categories, :supermedia_category_id, :integer
  end
end
