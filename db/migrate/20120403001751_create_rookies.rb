class CreateRookies < ActiveRecord::Migration
  def change
    create_table :rookies do |t|
      t.integer :position
      t.string :name
      t.text :payload

      t.timestamps
    end
  end
end
