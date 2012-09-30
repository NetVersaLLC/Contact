class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.text :short_description

      t.timestamps
    end
  end
end
