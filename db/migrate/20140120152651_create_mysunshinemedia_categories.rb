class CreateMysunshinemediaCategories < ActiveRecord::Migration
  def change
    create_table :mysunshinemedia_categories do |t|
      t.string :name
      t.integer :parent_id
      add_column :google_categories, :mysunshinemedia_category_id, :integer
      t.timestamps
    end
  end
end
