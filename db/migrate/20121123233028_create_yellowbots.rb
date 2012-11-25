class CreateYellowbots < ActiveRecord::Migration
  def change
    create_table :yellowbots do |t|
      t.integer :business_id
      t.datetime :force_update
      t.text :secrets
      t.text :email

      t.timestamps
    end
    add_index :yellowbots, :business_id
  end
end
