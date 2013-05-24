# IMPORTANT: This file is generated by backburner-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of backburner-rails. Consider adding your own code to a new file
# instead of editing this one. backburner will automatically load all features/**/*.rb
# files.


unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks


begin

  namespace :backburner do
    task :work do
      require 'backburner/tasks'
      require Pathname(Rails.root) + 'config/application'
      #Contact::Application.initialize!
      #Backburner.work('business-manage')
      #puts "Backburner.work('business-manage')"
      puts User
    end
  end

rescue LoadError
  desc 'backburner rake task not available (backburner not installed)'
  task :backburner do
    abort 'backburner rake task is not available. Be sure to install backburner as a gem or plugin'
  end
end

end