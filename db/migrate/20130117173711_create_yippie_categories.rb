class CreateYippieCategories < ActiveRecord::Migration
  def change
    create_table :yippie_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :yippie_categories, :parent_id
    add_index :yippie_categories, :name
    add_column :google_categories, :yippie_category_id, :integer
  end
end
