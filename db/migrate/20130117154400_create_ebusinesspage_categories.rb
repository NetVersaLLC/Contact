class CreateEbusinesspageCategories < ActiveRecord::Migration
  def change
    create_table :ebusinesspage_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :ebusinesspage_categories, :parent_id
    add_index :ebusinesspage_categories, :name
    add_column :google_categories, :ebusinesspage_category_id, :integer
  end
end
