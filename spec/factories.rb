FactoryGirl.define do 
  factory :business do 
    business_name 'bname' 
    contact_gender 'Male' 
    contact_first_name 'Ronald' 
    contact_last_name 'McDonald' 
    contact_birthday '1/1/1900' 
    local_phone '617-555-1212' 
    address  'Main Street' 
    city     'Somewhere' 
    state    'CA' 
    zip      '12811' 
    business_description 'asldkjf laskjlkasjdklasdjflkasjdlkasjlkas jlk asjlkasjlksad jlaksj;alsk jd;laksj;lak sjlaskdhasdf' 
    geographic_areas 'Worldwide' 
    year_founded  2000 
    category1 'wine bar' 
    category2 'funhouse' 
    category3 'hamburgers' 
  end 

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
