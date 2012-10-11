data = {}
data[ 'first_name' ]        = business.contact_first_name
data[ 'last_name' ]         = business.contact_last_name
data[ 'gender' ]            = business.contact_gender
data[ 'month' ]             = Date::MONTHNAMES[business.birthday.month]
data[ 'day' ]               = business.birthday.day
data[ 'year' ]              = business.birthday.year
data[ 'country' ]           = 'United States'
data[ 'language' ]          = 'English'
data[ 'zip' ]               = business.zip
data[ 'password' ]          = Yahoo.make_password
data[ 'secret_answer_1' ]   = Yahoo.make_secret_answer1
data[ 'secret_answer_2' ]   = Yahoo.make_secret_answer2
data
