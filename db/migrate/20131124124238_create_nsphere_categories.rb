class CreateNsphereCategories < ActiveRecord::Migration
  def change
    add_column :google_categories, :model_category_id, :integer
    create_table :nsphere_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end
end
