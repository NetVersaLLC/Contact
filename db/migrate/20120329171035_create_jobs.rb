class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :name
      t.integer :status
      t.boolean :wait
      t.text :payload

      t.timestamps
    end
    add_index :jobs, :user_id
    add_index :jobs, :status
    add_column :users, :authentication_token, :string
  end
end
