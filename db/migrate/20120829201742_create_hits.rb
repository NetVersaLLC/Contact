class CreateHits < ActiveRecord::Migration
  def change
    create_table :hits do |t|
      t.integer :tag_id
      t.integer :category_id
      t.string :site
      t.string :assignment
      t.string :remote_ip
      t.string :user_agent

      t.timestamps
    end
    add_index :hits, :tag_id
    add_index :hits, :category_id
    add_index :hits, :site
  end
end
