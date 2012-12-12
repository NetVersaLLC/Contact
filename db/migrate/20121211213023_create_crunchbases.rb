class CreateCrunchbases < ActiveRecord::Migration
  def change
    create_table :crunchbases do |t|
      t.integer :business_id
      t.string :email
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
    add_index :crunchbases, :business_id
  end
end
