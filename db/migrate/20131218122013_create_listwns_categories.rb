class CreateListwnsCategories < ActiveRecord::Migration
  def change
    create_table :listwns_categories do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
    add_column :google_categories, :listwns_category_id, :integer
  end
end
