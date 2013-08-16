class AddStatusToTasks < ActiveRecord::Migration
  def up
    add_column :tasks, :status, :string, :default => 'new' 
    add_column :tasks, :completed_at, :datetime

    say 'Setting all Tasks status => "completed"' 

    Task.update_all( status: 'completed' ) 
  end
  def down 
    remove_column :tasks, :status 
    remove_column :tasks, :completed_at 
  end 
end
