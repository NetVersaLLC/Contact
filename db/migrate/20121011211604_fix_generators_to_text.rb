class FixGeneratorsToText < ActiveRecord::Migration
  def change
    change_column :failed_jobs, :data_generator, :text
    change_column :completed_jobs, :data_generator, :text
  end
end
