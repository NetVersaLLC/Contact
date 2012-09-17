class ChangeModelToDataGenerator < ActiveRecord::Migration
  def change
    remove_column :jobs, :wait
    remove_column :jobs, :data
    remove_column :failed_jobs, :wait
    rename_column :failed_jobs, :model, :data_generator
    remove_column :completed_jobs, :wait
    rename_column :completed_jobs, :model, :data_generator
  end
end
