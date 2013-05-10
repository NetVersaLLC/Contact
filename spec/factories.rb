FactoryGirl.define do 

  factory :label do 
    name "towncenter" 
    login "login" 
    password "pswd" 
    domain "www.example.com" 
    logo_file_name "nothing" 
    credits 10
  end 

  factory :user do 
    email 'user@contact.dev' 
    password 'password' 
    access_level User.owner 
    label 
  end 

  factory :location do 
    zip 92626
    city 'Costa Mesa' 
    state 'CA'
    latitude 33.680139
    longitude -117.908452
  end 
  
end 
