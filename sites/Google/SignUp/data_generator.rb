email_names = Google.make_email_names

data = { # 'email' => '',
         # 'phone_number' => business.local_phone,
         'pass' => Google.make_pass,
         'first name' => business.contact_first_name,
         'last name' => business.contact_last_name,
         'email_name' => email_names.shift,
         'acceptable_alternates' => email_names,
         'address' => business.address + ' ' + business.address2,
         'zipcode' => business.zip,
         'country' => 'United States'
}
data
