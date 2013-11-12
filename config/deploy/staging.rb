set  :rails_env ,'production'
set  :branch    ,'staging'
server 'staging.netversa.com', :app, :web, :db, :primary => true

after 'deploy:migrations' do
  print 'hello world'
end
#after 'deploy:migrations',  'daemons:stop'
#after 'daemons:stop',  'daemons:start'
