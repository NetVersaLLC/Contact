class CreateLocalcensusCategories < ActiveRecord::Migration
  def change
    create_table :localcensus_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :localcensus_categories, :parent_id
    add_index :localcensus_categories, :name
    add_column :google_categories, :localcensus_category_id, :integer

  end
end
