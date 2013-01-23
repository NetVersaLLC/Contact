class CreateCitisquareCategories < ActiveRecord::Migration
  def change
    create_table :citisquare_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
	  end
    add_index :citisquare_categories, :parent_id
    add_index :citisquare_categories, :name
	unless column_exists? :google_categories, :citisquare_category_id
		add_column :google_categories, :citisquare_category_id, :integer
	end
  end
end
