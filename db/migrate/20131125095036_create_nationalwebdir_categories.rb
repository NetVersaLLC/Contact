class CreateNationalwebdirCategories < ActiveRecord::Migration
  def change
    create_table :nationalwebdir_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    add_column :google_categories, :nationalwebdir_category_id, :integer
  end
end
