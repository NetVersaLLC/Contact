class TasksAgainPlease < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :business_id
      t.datetime :started_at
      t.timestamps
    end
    add_index :tasks, :business_id

  end
end
