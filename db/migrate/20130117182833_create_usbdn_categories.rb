class CreateUsbdnCategories < ActiveRecord::Migration
  def change
    create_table :usbdn_categories do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
    add_index :usbdn_categories, :parent_id
    add_index :usbdn_categories, :name
    add_column :google_categories, :usbdn_category_id, :integer
    add_column :usbdns, :usbdn_category_id, :integer
  end
end
