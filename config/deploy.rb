require "bundler/capistrano"
load "deploy/assets"

#set :ssh_options, {
#  :keys => "C:\\msysgit\\.ssh\\id_rsa"
#}

set :application, "Contact"
set :repository,  "git@github.com:jjeffus/Contact.git"
set :scm, :git
set :user, 'deploy'
set :deploy_to, '/home/deploy/contact'
set :keep_releases, 5
server "franklin.netversa.com", :app, :web, :db, :primary => true
set :default_shell, "bash -l"
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user
set :use_sudo   , false

namespace :deploy do
  desc "Start the Thin processes"
  task :start do
    sudo "service contact start"
  end

  desc "Stop the Thin processes"
  task :stop do
    sudo "service contact stop"
  end

  desc "Restart the Thin processes"
  task :restart do
    sudo "service contact restart"
  end
end

after "deploy", "deploy:migrate"
