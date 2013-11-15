set  :rails_env ,'production'
set  :branch    ,'staging'
server 'staging.netversa.com', :app, :worker, :db, :primary => true

