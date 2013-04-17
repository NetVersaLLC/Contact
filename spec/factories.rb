FactoryGirl.define do 
  factory :label do 
    name "towncenter" 
    login "login" 
    password "pswd" 
    domain "www.contact.dev" 
    logo_file_name "nothing" 
  end 

  factory :user do 
    email 'user@contact.dev' 
    password 'password' 
    access_level User.owner 
    label 
  end 

  factory :admin, class: User  do 
    email 'admin@contact.dev' 
    password 'password' 
    access_level User.admin 
    label 
  end 
end 
