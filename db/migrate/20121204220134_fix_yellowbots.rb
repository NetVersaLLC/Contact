class FixYellowbots < ActiveRecord::Migration
  def change
    drop_table :yellowbots
    add_column :yellow_bots, :secrets, :text
    add_column :yellow_bots, :business_id, :integer
  end
end
