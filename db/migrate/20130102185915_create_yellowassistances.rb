class CreateYellowassistances < ActiveRecord::Migration
  def change
    create_table :yellowassistances do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :yellowassistances, :business_id
  end
end
