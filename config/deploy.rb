require "bundler/capistrano"

#set :ssh_options, {
#  :keys => "C:\\msysgit\\.ssh\\id_rsa"
#}
set :application, "Contact"
set :repository,  "git@github.com:jjeffus/Contact.git"
set :scm, :git
set :user, 'deploy'
set :deploy_to, '/home/deploy/public_html'
set :keep_releases, 5
server "cite.netversa.com", :app, :web, :db, :primary => true

namespace :deploy do
  desc "Start the Thin processes"
  task :start do
    sudo "service thin start"
  end

  desc "Stop the Thin processes"
  task :stop do
    sudo "service thin stop"
  end

  desc "Restart the Thin processes"
  task :restart do
    sudo "service thin restart"
  end
end

after "deploy", "deploy:migrate"
