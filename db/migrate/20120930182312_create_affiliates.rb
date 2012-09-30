class CreateAffiliates < ActiveRecord::Migration
  def change
    create_table :affiliates do |t|
      t.string :name
      t.string :code
      t.boolean :active

      t.timestamps
    end
    add_index :affiliates, :code
  end
end
