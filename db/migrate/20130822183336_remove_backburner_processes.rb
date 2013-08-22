class RemoveBackburnerProcesses < ActiveRecord::Migration
  def change
    drop_table :backburner_processes
  end
end
