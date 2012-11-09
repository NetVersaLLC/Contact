class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :business_id
      t.string :title
      t.text :body
      t.string :url

      t.timestamps
    end
    add_index :notifications, :business_id
  end
end
