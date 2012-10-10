class CreateBingCategories < ActiveRecord::Migration
  def change
    create_table :bing_categories do |t|
      t.integer :parent_id
      t.string :name
      t.string :name_path

      t.timestamps
    end
    add_index :bing_categories, :parent_id
    add_index :bing_categories, :name_path
  end
end
