class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.integer :user_id
      t.string :name
      t.string :key
      t.integer :size

      t.timestamps
    end
    add_index :downloads, :user_id
  end
end
