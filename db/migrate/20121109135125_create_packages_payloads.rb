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
    Package.create do |pac|
      pac.name = 'Starter'
      pac.price = 99.99
      pac.description = "This is the long description of this package. It can contain HTML and could be several pages if that made sense."
      pac.short_description = "This is the short description, it's meant to be one or two sentences."
    end
  end
end
