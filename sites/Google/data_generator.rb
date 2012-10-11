=begin
data = {}
data['area_code'] = business.contact_phone.split("-")[0]
data['password'] = Yahoo.create_password
data['category_id'] = business.yelps.first.yelp_category_id
data

'email' => business.googles.first.email

answer = ContactJob.phone_verify(business) #read_phone_verify(file, business)
browser.text_field(:id, 'answer')set answer


'pass' => Google.make_pass

'owner' = business.contact_name
firstname => business.contact_first_name
phone

=end

business = {
  'email'                 => '', # Actual gmail email
  'pass'                  => '', # Actual gmail pasword
  'owner'                 => 'Sir Apple Boss',
  'first name'            => 'Sir Apple',
  'last name'             => 'Boss',
  'business'              => 'Apple Newton', # Business name for google can't be longer than 50 characters
  'acceptable_alternates' => ["apple.in.sky","apples.are.yummy","apples.go.round"],
  'phone'                 => '(540)622-2342',
  'address'               => '101 apple orchard ln.',
  'zipcode'               => '22601',
  'zip'                   => '22601',
  'country'               => 'United States'
}
#=end
