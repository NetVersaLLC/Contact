class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :name
      t.string :zip
      t.string :address
      t.string :phone
      t.string :city

      t.timestamps
    end
  end
end
