class CreateExpressbusinessdirectories < ActiveRecord::Migration
  def change
    create_table :expressbusinessdirectories do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :expressbusinessdirectories, :business_id
  end
end
