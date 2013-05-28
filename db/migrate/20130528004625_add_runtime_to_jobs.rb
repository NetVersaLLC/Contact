class AddRuntimeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :runtime, :string, :default => '2013-05-16 19:33:04'
  end
end
