class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :business_id
      t.string :name

      t.timestamps
    end
    add_index :products, :business_id
  end
end
