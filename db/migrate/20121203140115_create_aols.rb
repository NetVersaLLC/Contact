class CreateAols < ActiveRecord::Migration
  def change
    create_table :aols do |t|
      t.integer :business_id
      t.datetime :force_update
      t.text :secrets
      t.string :username

      t.timestamps
    end
    add_index :aols, :username
  end
end
