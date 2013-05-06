class CreateVitelityNumbers < ActiveRecord::Migration
  def change
    create_table :vitelity_numbers do |t|
      t.integer :business_id
      t.string :ratecenter
      t.string :state
      t.string :did
      t.string :forwards_to
      t.string :address
      t.string :suite
      t.string :zip
      t.boolean :active

      t.timestamps
    end
    add_index :vitelity_numbers, :state
    add_index :vitelity_numbers, :business_id
  end
end
