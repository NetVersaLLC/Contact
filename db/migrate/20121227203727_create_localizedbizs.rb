class CreateLocalizedbizs < ActiveRecord::Migration
  def change
    create_table :localizedbizs do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :localizedbizs, :business_id
  end
end
