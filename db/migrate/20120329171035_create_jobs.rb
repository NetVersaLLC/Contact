class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer  :business_id
      t.string   :name
      t.string   :model
      t.integer  :status
      t.string   :status_message
      t.text     :payload
      t.text     :returned
      t.boolean  :wait
      t.datetime :waited_at
      t.integer  :position

      t.timestamps
    end
    add_index :jobs, :business_id
    add_index :jobs, :status

    create_table :completed_jobs do |t|
      t.integer  :business_id
      t.string   :name
      t.string   :model
      t.integer  :status
      t.string   :status_message
      t.text     :payload
      t.text     :returned
      t.boolean  :wait
      t.datetime :waited_at
      t.integer  :position

      t.timestamps
    end
    add_index :completed_jobs, :business_id
    add_index :completed_jobs, :status

    create_table :failed_jobs do |t|
      t.integer  :business_id
      t.string   :name
      t.string   :model
      t.integer  :status
      t.string   :status_message
      t.text     :payload
      t.text     :returned
      t.boolean  :wait
      t.datetime :waited_at
      t.integer  :position

      t.timestamps
    end
    add_index :failed_jobs, :business_id
    add_index :failed_jobs, :status
  end
end
