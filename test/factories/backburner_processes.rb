# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :backburner_process do
    user_id 1
    business_id 1
    all_processes "MyText"
    processed "MyText"
  end
end
