class CreateShopinusaCategories < ActiveRecord::Migration
  def change
    create_table :shopinusa_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
	add_index :shopinusa_categories, :parent_id
    add_index :shopinusa_categories, :name
	unless column_exists? :google_categories, :shopinusa_category_id
		add_column :google_categories, :shopinusa_category_id, :integer
	end
  end
end
