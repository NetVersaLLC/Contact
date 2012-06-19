class AddDataToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :data, :text
  end
end
