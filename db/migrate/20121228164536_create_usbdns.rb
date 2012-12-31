class CreateUsbdns < ActiveRecord::Migration
  def change
    create_table :usbdns do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :usbdns, :business_id
  end
end
