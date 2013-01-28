class CreateDigabusinessCategories < ActiveRecord::Migration
  def change
    create_table :digabusiness_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :digabusiness_categories, :parent_id
    add_index :digabusiness_categories, :name
    add_column :google_categories, :digabusiness_category_id, :integer
  end
end
