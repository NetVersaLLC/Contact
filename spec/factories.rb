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
    email "user@contact.dev"
    password 'password' 
    password_confirmation 'password'
    authentication_token '82ht987h987h'
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
    founded { SecureRandom.random_number(2013) }
    alexa_us_traffic_rank { SecureRandom.random_number(100) }
    page_rank { SecureRandom.random_number(10) }
    enabled_for_scan '1'
  end

  factory :payload do
    sequence(:name, 0) {|n| "Step#{n}" }
    active false
    data_generator  "data = {}\ndata[ 'hotmail' ]      \t= business.bings.first.email\ndata[ 'password' ]     \t= business.bings.first.password\ndata[ 'hours' ]\t\t\t= Getfave.consolidate_hours(business)\ndata[ 'founded' ]\t\t= business.year_founded\ndata[ 'mobile' ]\t\t= business.mobile_phone\ndata[ 'mobile_appears' ] = business.mobile_appears\ndata[ 'tollfree' ]\t\t= business.toll_free_phone\ndata[ 'mobile' ]\t\t= business.fax_number\ndata[ 'payments' ]\t\t= Bing.make_payments(business)\ndata[ 'description' ]\t= business.business_description\ndata\n"
    client_script  "sign_in_business( data )\nsleep 2\nWatir::Wait.until { @browser.text.include? \"All Businesses\" }\n\n@browser.link(:text => 'Edit').click\n\nsleep 2\nretries = 3\nbegin\n\t@browser.h5(:text  'Additional Business Details').when_present.click\n\tsleep 1 #Animation length\n\t@browser.text_field(:name => 'AdditionalBusinessInfo.OpHourDetail.AdditionalInformation').set data['hours']\n\t@browser.text_field(:name => 'AdditionalBusinessInfo.Description').set data['description']\n\t@browser.text_field(:name => 'AdditionalBusinessInfo.YearEstablished').set data['founded']\nrescue Selenium::WebDriver::Error::ElementNotVisibleError\n\tif retries > 0\n\t\tretries -= 1\n\t\tretry\n\telse\n\t\tputs(\"Cound not add business hours, description, and year founded.\")\n\tend\nend\n\nretries = 3\nbegin\n\t@browser.h5(:text => \"Other Contact Information\").click\n\tsleep 2\n\tif data['mobile_appears']\n\t\t@browser.text_field(:name => 'AdditionalBusinessInfo.MobilePhoneNumber').set data['mobile']\n\tend\n\t@browser.text_field(:name => 'AdditionalBusinessInfo.TollFreeNumber').set data['tollfree']\n\t@browser.text_field(:name => 'AdditionalBusinessInfo.FaxNumber').set data['fax']\nrescue Selenium::WebDriver::Error::ElementNotVisibleError\n\tif retries > 0\n\t\tretries -= 1\n\t\tretry\n\telse\n\t\tputs(\"Cound not add additional phone numbers\")\n\tend\nend\n\nretries = 3\nbegin\n\t@browser.h5(:text => \"General Information\").click\n\tsleep 1\n\n\tdata['payments'].each do |pay|\n\t\t@browser.checkbox(:id => pay).clear\n\t\t@browser.checkbox(:id => pay).click\n\tend\nrescue Selenium::WebDriver::Error::ElementNotVisibleError\n\tif retries > 0\n\t\tretries -= 1\n\t\tretry\n\telse\n\t\tputs(\"Cound not add payment methods.\")\n\tend\nend\n\n@browser.button(:id => 'submitBusiness').click\n\nsleep 2\nWatir::Wait.until { @browser.text.include? \"All Businesses\" }\n\nif @chained\n\tself.start(\"Bing/VerifyMail\")\nend\n\ntrue"
    association :site, name: "Private"
  end

  factory :site_transition do
    from "initial"
    to "signup"
    on "signup"
    association :site, name: "Private"

    after(:create) do |site_transition, evaluator|
      FactoryGirl.create_list(:site_event_payload, 3, site_transition: site_transition)
    end

  end

  factory :site_event_payload do
    payload
    site_transition
    sequence(:order)
    required true
  end

  factory :business_site_state do
    association :site, name: "Private"
    business
    state "initial"
  end

end
