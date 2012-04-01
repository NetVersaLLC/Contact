class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
    add_index :tasks, :user_id
    add_index :tasks, :name
  end
end
