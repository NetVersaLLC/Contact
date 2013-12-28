class AddModeToPayloads < ActiveRecord::Migration
  def up
    create_table :business_site_modes do |t|
      t.references :site
      t.references :business
      t.references :mode

      t.timestamps
    end

    add_index :business_site_modes, [:site_id, :business_id], :unique => true

    add_column :payloads, :to_mode_id, :integer

    add_column :jobs, :parent_id, :integer
    add_index(:jobs, :parent_id)

    add_column :completed_jobs, :parent_id, :integer
    add_column :failed_jobs, :parent_id, :integer

  end

  def down
    remove_column :payloads, :to_mode_id
    remove_index :jobs, :parent_id
    remove_column :jobs, :parent_id
    remove_column :completed_jobs, :parent_id
    remove_column :failed_jobs, :parent_id
    drop_table :business_site_modes
  end
end
