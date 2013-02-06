class CreateKudzuCategories < ActiveRecord::Migration
  def change
    create_table :kudzu_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
     add_index :kudzu_categories, :parent_id
    add_index :kudzu_categories, :name
    
    unless column_exists? :google_categories, :kudzu_category_id
      add_column :google_categories, :kudzu_category_id, :integer
    end
    unless column_exists? :kudzus, :kudzu_category_id
      add_column :kudzus, :kudzu_category_id, :integer
    end
  end
end
