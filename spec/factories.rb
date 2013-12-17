FactoryGirl.define do 
  factory :business do 
    business_name 'bname' 
    contact_gender 'Male' 
    contact_first_name 'Ronald' 
    contact_last_name 'McDonald' 
    contact_birthday '1/1/1900' 
    local_phone '617-555-1212' 
    mobile_phone '617-555-1111'
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
    keywords 'keywords' 
    status_message 'some status message' 
    services_offered 'service1, service2' 
    brands 'brands' 
    tag_line 'We Rock!' 
    job_titles 'ceo, manager' 
    corporate_name 'corporate name'
    contact_prefix 'Mr'
    category_description 'ecommerce'

    subscription
    user
    #crunchbase_attributes 'crunchbase'
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
    sequence(:email,0) {|n| "user#{n}@contact.dev"}
    password 'password' 
    password_confirmation 'password'
    authentication_token {SecureRandom.hex}
    access_level User.owner
    label 
  end 

  factory :location do 
    zip '92614'
    city 'Costa Mesa' 
    state 'CA'
    latitude '33.680139'
    longitude '-117.908452'
  end 

  factory :package do 
    price 299 
    monthly_fee 19 
    label 
  end 

  factory :coupon do 
    percentage_off 100
    label 
  end 

  factory :payment do
    label_id 1
  end

  factory :subscription do
    label_id 5
    active true
    package_id 1
    monthly_fee 20
  end

  factory :transaction_event do
    label_id 2
    package_id 5
  end

  factory :scan do
    city      'Noname City'
    site_name 'Foursquare'
    latitude  '41.650967'
    longitude '-83.536485'
    state     'Ohio'
    state_short 'OH'
    county    'Lucas'
    country   'US'
    task_status '0'

  end

  factory :report do
    business      'NetVersa'
    zip           '92614'
    phone         '855-418-9357'
    package_id    '1'
    ident         { SecureRandom.uuid }
    email         'help@netversa.com'
    referrer_code '234'
    status        'started'

    label
  end

  factory :site do
    owner 'Private'
    name 'Private'
    founded { SecureRandom.random_number(2013) }
    alexa_us_traffic_rank { SecureRandom.random_number(100) }
    page_rank { SecureRandom.random_number(10) }
    enabled_for_scan '1'
  end

  factory :business_site_mode do
    business
    site
    mode 1
  end

  factory :payload do
    sequence(:name, 0) { |n| "Step#{n}" }
    active false
    data_generator "data = {} \n data[ 'mail' ]= business.user.email"
    client_script "nothing"
    site
    factory :payload_chain do
      after(:create) { |root|
        payloads= create_list(:payload, 2, site: root.site)
        payloads[0].parent_id= root.id
        payloads[0].name= "Step1"
        payloads[1].parent_id= payloads[0].id
        payloads[1].name= "Step2"        
        payloads[1].from_mode= 1
        payloads[1].to_mode= 2
        payloads.each{|e| e.save};
      }
    end
  end

  factory :job do
    sequence(:name, 0) { |n| "Private/Step#{n}" }
    business
    runtime {Time.now}
    status_message "message from heaven"
    payload "nothing"
    data_generator "data = {} \n data[ 'mail' ]= business.user.email"
    status {Job::TO_CODE[:new]}
    factory :running_job do
      status {Job::TO_CODE[:running]}
    end
    factory :waited_job do
      status {Job::TO_CODE[:running]}
      waited_at {Time.now}
    end
    factory :long_waited_job do
      status {Job::TO_CODE[:running]}
      waited_at {Date.yesterday}
    end
  end

  factory :completed_job do
    sequence(:name, 0) { |n| "Private/Step#{n}" }
    business
    status_message "message from heaven"
    status {Job::TO_CODE[:finished]}
  end

end
