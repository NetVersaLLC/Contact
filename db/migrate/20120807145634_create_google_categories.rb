class CreateGoogleCategories < ActiveRecord::Migration
  def change
    create_table :google_categories do |t|
      t.string :name
      t.string :slug
      t.integer :yelp_category_id

      t.timestamps
    end
    add_index :google_categories, :name
    add_index :google_categories, :slug
    add_index :google_categories, :yelp_category_id
    Rake::Task['categories:google'].invoke
  end
end
