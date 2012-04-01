require "bundler/capistrano"

set :ssh_options, {
  :keys => "C:\\msysgit\\.ssh\\id_rsa"
}
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
    sudo "bundle exec thin start -C /etc/thin/contact.yml"
  end

  desc "Stop the Thin processes"
  task :stop do
    sudo "bundle exec thin stop -C /etc/thin/contact.yml"
  end

  desc "Restart the Thin processes"
  task :restart do
    sudo "bundle exec thin restart -C /etc/thin/contact.yml"
  end
end

after "deploy", "deploy:migrate"
