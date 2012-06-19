class CreatePings < ActiveRecord::Migration
  def change
    create_table :pings do |t|
      t.integer :user_id
      t.integer :business_id
      t.string :message

      t.timestamps
    end
    add_index :pings, :user_id
    add_index :pings, :business_id
  end
end
