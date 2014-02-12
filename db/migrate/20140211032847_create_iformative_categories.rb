class CreateIformativeCategories < ActiveRecord::Migration
  def change
    create_table :iformative_categories do |t|
      t.string :name
      t.integer :parent_id
      add_column :google_categories, :iformative_category_id, :integer

      t.timestamps
    end
  end
end
