class CreateFacebookProfileCategories < ActiveRecord::Migration
  def change
    create_table :facebook_profile_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :facebook_profile_categories, :parent_id
    add_index :facebook_profile_categories, :name
    unless column_exists? :google_categories, :facebook_profile_category_id
      add_column :google_categories, :facebook_profile_category_id, :integer
    end    
    unless column_exists? :facebooks, :facebook_profile_category_id
      add_column :facebooks, :facebook_profile_category_id, :integer
    end
  end
end
