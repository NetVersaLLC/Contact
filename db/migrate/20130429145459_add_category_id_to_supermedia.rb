class AddCategoryIdToSupermedia < ActiveRecord::Migration
  def change
    add_column :supermedia, :supermedia_category_id, :integer
  end
end
