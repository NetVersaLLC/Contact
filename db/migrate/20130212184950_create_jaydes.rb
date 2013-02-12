class CreateJaydes < ActiveRecord::Migration
  def change
    create_table :jaydes do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
  end
end
