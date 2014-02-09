class AddSnoopitnowToGooglecategory < ActiveRecord::Migration
  def change
    add_column :google_categories, :snoopitnow_category_id, :integer
  end
end
