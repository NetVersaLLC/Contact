class CreateMapquestCategories < ActiveRecord::Migration
  def change
    create_table :mapquest_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :mapquest_categories, :parent_id
    add_column :mapquests, :mapquest_category_id, :integer
  end
end
