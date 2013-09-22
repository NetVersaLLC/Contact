namespace :reports do
  desc "Make all complted reports as completed"
  task :update_status => :environment do
    #pid_file = '/tmp/my_task.pid'
    #raise 'pid file exists!' if File.exists? pid_file
    #File.open(pid_file, 'w'){|f| f.puts Process.pid}
    #begin
      Report.update_statuses
    #ensure
    #  File.delete pid_file
    #end
  end
end