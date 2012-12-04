email_names = Google.make_email_names(business)

data = { 'phone' => business.local_phone.to_s,
         'pass' => Google.make_password,
         'first_name' => business.contact_first_name,
         'last_name' => business.contact_last_name,
	 'business' => business.business_name,
	 'email_name' => email_names,
         'acceptable_alternates' => email_names.shift,
         'address' => business.address + ' ' + business.address2,
	 'city' => business.city,
         'zipcode' => business.zip,
         'country' => 'United States',
	 'month' => Date::MONTHNAMES[business.birthday.month],
	 'alt_email' => 'test@test.com',
	 'day' => business.birthday.day.to_s,
	 'year' => business.birthday.year.to_s,
	 'gender' => business.contact_gender
}
data
