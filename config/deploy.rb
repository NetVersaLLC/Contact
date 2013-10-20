require 'capistrano-db-tasks'
require 'bundler/capistrano'
require 'rvm/capistrano'
require 'capistrano-unicorn'

set :stages, %w(production staging worker)
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
end

namespace :nginx do
  desc 'Reload Nginx'
  task :reload do
    sudo '/etc/init.d/nginx reload'
  end
end

namespace :thin do
  desc 'Restart Thin'
  task :restart do
    run 'rvmsudo /etc/init.d/contact restart'
  end
end

after "deploy:finalize_update" do
  run ["ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml",
       "ln -nfs #{shared_path}/config/scanserver.yml #{release_path}/config/scanserver.yml",
       "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml",
       "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
  ].join(" && ")
end

task :after_update_code do
  %w{labels}.each do |share|
    run "ln -s #{shared_path}/#{share} #{release_path}/#{share}"
  end
end

after 'deploy'           , 'deploy:migrations'
after 'deploy:migrations', 'deploy:assets'
after 'deploy:assets',     'after_update_code'
after 'after_update_code', 'nginx:reload'
after 'nginx:reload'     , 'thin:restart'

require './config/boot'
