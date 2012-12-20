class CreateFreebusinessdirectories < ActiveRecord::Migration
  def change
    create_table :freebusinessdirectories do |t|
      t.integer :business_id
      t.text :secrets
      t.datetime :force_update
      t.text :username

      t.timestamps
    end
    add_index :freebusinessdirectories, :business_id
  end
end
