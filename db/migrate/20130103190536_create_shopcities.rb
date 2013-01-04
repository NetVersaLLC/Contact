class CreateShopcities < ActiveRecord::Migration
  def change
    create_table :shopcities do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :shopcities, :business_id
  end
end
