FactoryGirl.define do
  factory :label1, class: Label do
    name "TownCenter"
    domain "sync.towncenter.com"
    logo_file_name "logo.png"
    logo_content_type "image/png"
    logo_file_size 11452
    login "842paDy7Gv"
    password "5sYC269Wa99J7kJ5" 
    credits 8934
    mail_from "support@towncenter.com"
    is_show_password true
    theme nil
  end

  factory :user1, class: User do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password "foobar"
    password_confirmation { |u| u.password }
    access_level User.owner 
    association :label, factory: :label1
  end

  factory :package1, class: Package do
    name "Starter"
    price 299
    description "Get listed in 45+ of the top online directories and..."
    short_description "Get listed in 45+ of the top online directories and..."
    monthly_fee 29
    association :label, factory: :label1
  end

  factory :subscription1, class: Subscription do
    tos_agreed true
    active true
    monthly_fee 29
    association :package, factory: :package1
    association :label, factory: :label1
  end

  factory :business1, class: Business do
    business_name "Test"
    corporate_name "test"
    contact_gender "Male"
    contact_prefix "Mr."
    contact_first_name "First"
    contact_middle_name ""
    contact_last_name "Last name"
    local_phone "518-242-2200"
    alternate_phone "123-123-1234"
    toll_free_phone "800-555-2121"
    mobile_phone "555-555-1211"
    mobile_appears true
    fax_number "876-890-4534"
    address "737 Albany Shaker Road"
    address2 "Suite 600"
    city  "Albany"
    state "NY"
    zip "12211"
    monday_open "03:30AM"
    monday_close "05:30PM"
    tuesday_open "08:30AM"
    tuesday_close "05:30PM"
    wednesday_open "04:00AM"
    wednesday_close "05:30PM"
    thursday_open "08:30AM"
    thursday_close "05:30PM"
    friday_open "08:30AM"
    friday_close "05:30PM"
    saturday_open "07:30AM"
    saturday_close "05:30PM"
    sunday_open "08:30AM"
    sunday_close "05:30PM"
    business_description "some description\r\nDescription\r\nDescription\r\nDescrip..."
    professional_associations "NKBA"
    geographic_areas "Worldwide"
    year_founded "1001"
    company_website "http://www.thekitchensuppl.com/contact.php"
    logo_file_name "DSC00870.jpg"
    logo_content_type "image/jpeg"
    logo_file_size 384277
    category1 "Kitchen Supply Store789"
    category2 "lkokl"
    category3 "Home Improvement Store"
    contact_birthday "05/21/2013"
    captcha_solves 190
    category4 "Kitchen Supply Store"
    category5 "Kitchen Remodeler"
    categorized true
    keywords "keyword1"
    status_message "some messabe"
    services_offered "a service"                  
    brands "a brand"
    tag_line "a tag line"
    job_titles "sale"
    is_client_downloaded false
    association :label, factory: :label1 
    association :user, factory: :user1
    association :subscription, factory: :subscription1
  end

  factory :goole_category1, class: GoogleCategory do
    name "Furniture Rental Service"
    slug "furniture_rental_service" 
  end

  factory :bing_category1, class: BingCategory do
    parent_id nil
    name "root"
    name_path nil
  end

  factory :bing_category2, class: BingCategory do
    name "Home & Family"
    name_path "[Application]\\Structure\\Content\\Categories\\Business\\Master\\11734"
    association :parent, factory: :bing_category1
  end

  factory :bing_category3, class: BingCategory do
    name "Kitchens"
    name_path "[Application]\\Structure\\Content\\Categories\\Business\\Master\\11734\\11858"
    association :parent, factory: :bing_category2
  end

  factory :bing1, class: Bing do
    email "thekitchensupply_253@hotmail.com"
    password "qcSAnkdMCw"
    secret_answer "hohoho"
    association :bing_category, factory: :bing_category3
    association :business, factory: :business1
  end

  factory :job1, class: Job do
    name "Bing/CreateListing"
    status 1
    status_message "Starting job"
    payload "#require 'gp_requires'\r\n\r\ndef retryable(options = {..."
    waited_at "2013-01-10 021001"
    data_generator "data = {}\ndata[ 'name' ] = business.busines..."
    business_id 219
  end
end
