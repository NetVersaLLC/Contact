class CreateBackburnerProcesses < ActiveRecord::Migration
  def change
    create_table :backburner_processes do |t|
      t.integer :user_id
      t.integer :business_id
      t.text :all_processes
      t.text :processed

      t.timestamps
    end
  end
end
