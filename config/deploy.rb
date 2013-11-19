require 'capistrano-db-tasks'
require 'bundler/capistrano'
require 'rvm/capistrano'
require 'capistrano-unicorn'

set :stages, %w(production staging worker teststaging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :rvm_type, :user
set :db_local_clean, true
set :deploy_to,             '/home/ubuntu/contact'
set :keep_releases,         2
set :default_shell,         "bash -l"
set :rvm_ruby_string,       '2.0.0'
set :rvm_type,              :user
set :git_enable_submodules, 1

set :application, 'contact'
set :scm        , :git
set :repository , 'git@github.com:NetVersaLLC/Contact.git'
set :user       , 'ubuntu'
set :use_sudo   , false
set :ssh_options, {:forward_agent => true}
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa_netversa"),File.join(ENV["HOME"], ".ssh", "id_rsa")]

namespace :deploy do
  desc 'Running migrations'
  task :migrations, :roles => :db do
    run "cd #{release_path} && bundle exec rake db:migrate RAILS_ENV=#{rails_env}"
  end

  desc 'Building assets'
  task :assets do
    run "cd #{release_path} && bundle exec rake assets:precompile"
  end

  task :stop_daemons, :roles => :worker do
    run "cd #{current_path} && bundle exec rake daemons:stop"
  end

  task :start_daemons, :roles => :worker do
    run "cd #{release_path} && bundle exec rake daemons:start"
  end

  desc 'Create symlinks'
  task :create_symlinks do
    run ["ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml",
         "ln -nfs #{shared_path}/config/scanserver.yml #{release_path}/config/scanserver.yml",
         "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml",
         "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
        ].join(" && ")
    %w{labels}.each do |share|
      run "ln -s #{shared_path}/#{share} #{release_path}/#{share}"
    end
  end
end

namespace :nginx do
  desc 'Reload Nginx'
  task :reload, :roles => [:app, :web] do
    sudo '/etc/init.d/nginx reload'
  end
end

namespace :deploy do
  task :restart do
    unicorn.restart
    nginx.reload
  end
end

# not used anymore
namespace :thin do
  desc 'Restart Thin'
  task :restart do
    run 'rvmsudo /etc/init.d/contact restart'
  end
end

after  'deploy:symlink', 'deploy:create_symlinks'
after  'deploy:create_symlinks' , 'deploy:migrations'
before 'deploy:migrations', 'deploy:stop_daemons'
after  'deploy:migrations', 'deploy:start_daemons'

require './config/boot'
