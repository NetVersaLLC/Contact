class CreateLinkedins < ActiveRecord::Migration
  def change
    create_table :linkedins do |t|
      t.integer :business_id
      t.string :email
      t.text :secrets
      t.string :status
      t.datetime :force_update

      t.timestamps
    end
    add_index :linkedins, :business_id
  end
end
