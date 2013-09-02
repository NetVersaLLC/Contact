class CreateMapquests < ActiveRecord::Migration
  def change
    create_table :mapquests do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.string :email

      t.timestamps
    end
    add_index :mapquests, :business_id
  end
end
