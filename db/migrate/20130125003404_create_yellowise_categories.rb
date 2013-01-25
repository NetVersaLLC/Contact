class CreateYellowiseCategories < ActiveRecord::Migration
  def change
    create_table :yellowise_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :yellowise_categories, :parent_id
    add_index :yellowise_categories, :name
    unless column_exists? :google_categories, :yellowise_category_id
      add_column :google_categories, :yellowise_category_id, :integer
    end
  end
end
