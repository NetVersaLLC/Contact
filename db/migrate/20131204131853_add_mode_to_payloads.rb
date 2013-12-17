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

    drop_table :modes

  end

  def down
    drop_table :business_site_modes
    CreateModes.new.change
  end
end
