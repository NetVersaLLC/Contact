class CreateZipproCategories < ActiveRecord::Migration
  def change
    create_table :zippro_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :zippro_categories, :parent_id
    add_index :zippro_categories, :name
    unless column_exists? :google_categories, :zippro_category_id
      add_column :google_categories, :zippro_category_id, :integer
    end
  end
end
