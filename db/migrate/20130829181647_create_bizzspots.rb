class CreateBizzspots < ActiveRecord::Migration
  def change
    create_table :bizzspots do |t|
      t.integer :business_id
      t.string :email
      t.string :username
      t.text :secrets
      t.datetime :force_update
      t.boolean :do_not_sync, :default => 0

      t.timestamps
    end
  end
end
