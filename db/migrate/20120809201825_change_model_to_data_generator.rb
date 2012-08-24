class ChangeModelToDataGenerator < ActiveRecord::Migration
  def change
    rename_column :payloads, :model, :data_generator
    remove_column :jobs, :wait
    rename_column :jobs, :model, :data_generator
    remove_column :jobs, :data
    remove_column :failed_jobs, :wait
    rename_column :failed_jobs, :model, :data_generator
    remove_column :completed_jobs, :wait
    rename_column :completed_jobs, :model, :data_generator
  end
end
