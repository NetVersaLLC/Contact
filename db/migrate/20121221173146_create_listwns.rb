class CreateListwns < ActiveRecord::Migration
  def change
    create_table :listwns do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :listwns, :business_id
  end
end
