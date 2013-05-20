class CreateMywebyellows < ActiveRecord::Migration
  def change
    create_table :mywebyellows do |t|
      t.integer :business_id
      t.string :email
      t.text :secrets
      t.datetime :force_update

      t.timestamps
    end
  end
end
