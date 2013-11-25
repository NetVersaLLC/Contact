class CreateYcphonebookCategories < ActiveRecord::Migration
  def change
    create_table :ycphonebook_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    add_column :google_categories, :ycphonebook_category_id, :integer
  end
end
