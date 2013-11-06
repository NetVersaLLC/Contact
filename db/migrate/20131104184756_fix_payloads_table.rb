class FixPayloadsTable < ActiveRecord::Migration
  def change
    add_column :payloads, :data_generator_signature, :text
    rename_column :payloads, :signature, :client_script_signature
    remove_column :payloads, :package_id
  end
end
