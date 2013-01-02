class CreateShopinusas < ActiveRecord::Migration
  def change
    create_table :shopinusas do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
    add_index :shopinusas, :business_id
  end
end
