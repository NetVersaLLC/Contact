class AddFooterToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :footer, :text
  end
end
