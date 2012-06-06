class CreateBings < ActiveRecord::Migration
  def change
    create_table :bings do |t|
      t.integer :business_id
      t.string :local_url
      t.string :email
      t.text :secrets
      t.string :status
      t.datetime :force_update

      t.timestamps
    end
    add_index :bings, :business_id
  end
end
