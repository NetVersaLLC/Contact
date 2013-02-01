class CreateExpertfocusCategories < ActiveRecord::Migration
  def change
    create_table :expertfocus_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
     add_index :expertfocus_categories, :parent_id
    add_index :expertfocus_categories, :name
    add_column :google_categories, :expertfocus_category_id, :integer
  end
end
