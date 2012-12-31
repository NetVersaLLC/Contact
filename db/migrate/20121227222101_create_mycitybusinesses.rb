class CreateMycitybusinesses < ActiveRecord::Migration
  def change
    create_table :mycitybusinesses do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
    add_index :mycitybusinesses, :business_id
  end
end
