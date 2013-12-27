class AddModeToPayloads < ActiveRecord::Migration
  def up
    create_table :business_site_modes do |t|
      t.references :site
      t.references :business
      t.references :mode

      t.timestamps
    end

    add_column :payloads, :to_mode_id, :integer

    add_column :jobs, :parent_id, :integer
    add_index(:jobs, :parent_id)

    add_column :completed_jobs, :parent_id, :integer
    add_column :failed_jobs, :parent_id, :integer

  end

  def down
    remove_column :payloads, :to_mode_id

  end
end