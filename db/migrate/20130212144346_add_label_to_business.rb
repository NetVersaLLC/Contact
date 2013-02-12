class AddLabelToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :label_id, :integer, :default => 1
  end
end
