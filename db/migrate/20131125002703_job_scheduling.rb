class JobScheduling < ActiveRecord::Migration
  def up

    create_table :site_transitions do |t|
      t.references :site
      t.string :on
      t.string :from
      t.string :to

      t.timestamps
    end

    create_table :business_site_states do |t|
      t.references :site
      t.references :business
      t.string :state

      t.timestamps
    end

    create_table :site_event_payloads do |t|
      t.references :site_transition
      t.references :payload
      t.integer :order
      t.boolean :required, :default => true

      t.timestamps
    end

    rename_table :jobs, :jobs_old

    create_table :jobs do |t|
      t.references :site_transition
      t.references :business
      t.string :status

      t.timestamps
    end

    create_table :job_payloads do |t|
      t.references :site_event_payload
      t.references :job
      t.datetime :failed_at
      t.datetime :last_run
      t.datetime :retries
      t.string :messages

      t.timestamps
    end

  end

  def down
    drop_table :job_payloads
    drop_table :jobs
    drop_table :site_event_payloads
    drop_table :business_site_states
    drop_table :site_transitions

    rename_table :jobs_old, :jobs
  end
end
