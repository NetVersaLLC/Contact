class CreateLocalezes < ActiveRecord::Migration
  def change
    create_table :localezes do |t|
      t.integer :business_id
      t.integer :localeze_category_id
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
    add_index :localezes, :business_id
  end
end
