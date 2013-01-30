class CreateMydestinations < ActiveRecord::Migration
  def change
    create_table :mydestinations do |t|
      t.datetime :force_update
      t.integer :business_id
      t.string :email
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
    add_index :mydestinations, :business_id
  end
end
