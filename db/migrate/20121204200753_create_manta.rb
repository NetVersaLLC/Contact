class CreateManta < ActiveRecord::Migration
  def change
    create_table :manta do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.string :email

      t.timestamps
    end
    add_index :manta, :business_id
  end
end
