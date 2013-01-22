class CreateYellowassistanceCategories < ActiveRecord::Migration
  def change
    create_table :yellowassistance_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
	add_index :yellowassistance_categories, :parent_id
    add_index :yellowassistance_categories, :name
	unless column_exists? :google_categories, :yellowassistance_category_id
		add_column :google_categories, :yellowassistance_category_id, :integer
	end
  end
end
