class AddReadyToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :ready, :text
  end
end
