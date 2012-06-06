class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.integer :business_id
      t.string :name

      t.timestamps
    end
    add_index :brands, :business_id
  end
end
