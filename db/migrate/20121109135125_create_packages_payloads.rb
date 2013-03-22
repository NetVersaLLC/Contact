class CreatePackagesPayloads < ActiveRecord::Migration
  def change
    drop_table :payloads
    create_table :packages_payloads do |t|
      t.integer :package_id
      t.string :site
      t.string :payload
      t.string :name
      t.string :description

      t.timestamps
    end
    add_index :packages_payloads, :package_id
    add_index :packages_payloads, :site
    add_index :packages_payloads, :payload
  end
end
