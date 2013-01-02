class CreateZippros < ActiveRecord::Migration
  def change
    create_table :zippros do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username
      t.text :secret1

      t.timestamps
    end
    add_index :zippros, :business_id
  end
end
