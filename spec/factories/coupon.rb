FactoryGirl.define do

  factory :coupon do
    name 'NETVERSA'
    code 'NETVERSA'
    percentage_off_monthly 100
    percentage_off_signup 100
    allowed_upto 1000
    dollars_off_monthly 0
    dollars_off_signup 0
    label_id 1

  end

  

 # factory :package do 
  #   price 299 
  #   monthly_fee 19 
  #   label 
  # end 
end

