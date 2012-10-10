class AddYelpIdToGoogleCategories < ActiveRecord::Migration
  def change
    add_column :google_categories, :yahoo_category_id, :integer
    add_column :google_categories, :bing_category_id, :integer
  end
end
