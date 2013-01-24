class CreateYelloweeCategories < ActiveRecord::Migration
  def change
    create_table :yellowee_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :yellowee_categories, :parent_id
    add_index :yellowee_categories, :name
    unless column_exists? :google_categories, :yellowee_category_id
      add_column :google_categories, :yellowee_category_id, :integer
    end
  end
end
