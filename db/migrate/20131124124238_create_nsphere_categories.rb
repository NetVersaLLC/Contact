class CreateNsphereCategories < ActiveRecord::Migration
  def change
    create_table :nsphere_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    add_column :google_categories, :nsphere_category_id, :integer
  end
end
