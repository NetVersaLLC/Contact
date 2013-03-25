class AddTempPass < ActiveRecord::Migration
  def change
    add_column :users, :callcenter, :boolean
  end
end
