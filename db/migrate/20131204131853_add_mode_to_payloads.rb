class AddModeToPayloads < ActiveRecord::Migration
  def up
    create_table :business_site_modes do |t|
      t.references :site
      t.references :business
      t.integer :mode

      t.timestamps
    end

    add_column :jobs, :retries, :integer
    add_column :jobs, :parent_id, :integer
    add_index(:jobs, :parent_id)

    remove_column :businesses, :mode_id
    remove_column :payloads, :mode_id
    
    add_column :payloads, :from_mode, :integer
    add_column :payloads, :to_mode, :integer
    
    add_column :completed_jobs, :parent_id, :integer
    add_column :failed_jobs, :parent_id, :integer
    change_column_default(:payloads, :parent_id, nil)  
    drop_table :modes
  end

  def down
    drop_table :business_site_modes
    CreateModes.new.change
  end
end
