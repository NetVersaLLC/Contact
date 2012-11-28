data = { 'phone' => business.local_phone,
         'pass' => Google.make_password,
         'first_name' => business.contact_first_name,
         'last_name' => business.contact_last_name,
	 'business' => business.business_name,
         'acceptable_alternates' => email_names,
         'address' => business.address + ' ' + business.address2,
         'zipcode' => business.zip,
         'country' => 'United States',
	 'month' => Date::MONTHNAMES[business.birthday.month],
	 'alt_email' = 'test@test,com'
	 'day' => business.birthday.day.to_s,
	 'year' => business.birthday.year.to_s,
	 'gender' => business.contact_gender
}
data
