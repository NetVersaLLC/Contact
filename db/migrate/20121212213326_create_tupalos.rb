class CreateTupalos < ActiveRecord::Migration
  def change
    create_table :tupalos do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
  end
end
