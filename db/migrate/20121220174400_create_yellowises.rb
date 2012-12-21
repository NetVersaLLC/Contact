class CreateYellowises < ActiveRecord::Migration
  def change
    create_table :yellowises do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :yellowises, :business_id
  end
end
