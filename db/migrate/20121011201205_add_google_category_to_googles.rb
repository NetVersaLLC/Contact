class AddGoogleCategoryToGoogles < ActiveRecord::Migration
  def change
    add_column :googles, :google_category_id, :integer
  end
end
