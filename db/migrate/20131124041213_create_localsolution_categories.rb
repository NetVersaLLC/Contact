class CreateLocalsolutionCategories < ActiveRecord::Migration
  def change
    create_table :localsolution_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    add_column :google_categories, :localsolution_category_id, :integer
  end
end
