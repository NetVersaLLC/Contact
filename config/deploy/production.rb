set  :rails_env ,'production'
set  :branch    ,'production'
server 'ec2-174-129-121-33.compute-1.amazonaws.com','ec2-23-22-146-4.compute-1.amazonaws.com', :app, :web, :db, :primary => true
