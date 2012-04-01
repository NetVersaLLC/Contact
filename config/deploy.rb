set :ssh_options, {
  :keys => "C:\\msysgit\\.ssh\\id_rsa"
}
set :application, "Contact"
set :repository,  "git@github.com:jjeffus/Contact.git"
set :scm, :git
set :user, 'deploy'
set :deploy_to, '/home/deploy/public_html'
set :keep_releases, 5
role :web, "cite.netversa.com"
role :app, "cite.netversa.com"
role :db,  "cite.netversa.com", :primary => true
