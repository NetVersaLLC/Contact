class CreateMysheriffCategories < ActiveRecord::Migration
  def change
    create_table :mysheriff_categories do |t|
      t.string :name
      t.integer :parent_id
      
      add_column :google_categories, :mysheriff_category_id, :integer
      t.timestamps
    end
  end
end
