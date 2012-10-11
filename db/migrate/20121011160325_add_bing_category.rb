class AddBingCategory < ActiveRecord::Migration
  def change
    add_column :bings, :bing_category_id, :integer
  end
end
