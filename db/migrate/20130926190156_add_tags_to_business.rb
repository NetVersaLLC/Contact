class AddTagsToBusiness < ActiveRecord::Migration
  def change
  	add_column :businesses, :tags, :string
  end
end
