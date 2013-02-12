class RemoveHits < ActiveRecord::Migration
  def change
    drop_table :hits
  end
end
