class CreateMerchantcircles < ActiveRecord::Migration
  def change
    create_table :merchantcircles do |t|
      t.datetime :force_update
      t.text :secrets
      t.integer :business_id
      t.string :email

      t.timestamps
    end
    add_index :merchantcircles, :business_id
  end
end
