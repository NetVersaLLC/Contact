class CreateLocalndexes < ActiveRecord::Migration
  def change
    create_table :localndexes do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :localndexes, :business_id
  end
end
