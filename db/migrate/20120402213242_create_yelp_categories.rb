class CreateYelpCategories < ActiveRecord::Migration
  def change
    create_table :yelp_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :yelp_categories, :parent_id
    Rake::Task['yelp:categories'].invoke
  end
end
