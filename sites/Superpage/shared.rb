def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\business_captcha.png"
  obj = @browser.image( :xpath, "/html/body/div[2]/div[2]/div/div/form/div/table/tbody/tr[2]/td/div/div[2]/table/tbody/tr[10]/td[2]/div/img" )
  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image

  CAPTCHA.solve image, :manual
end


def prepare_time(time_string)
time_string.gsub('PM', ' PM')
time_string.gsub('AM', ' AM')
time_string
end


def are_hours_set(business)
@hoursset = false

if business.monday_enabled
	@hoursset =  true
else if business.tuesday_enabled
	@hoursset =  true
else if business.wednesday_enabled
	@hoursset =  true
else if business.thursday_enabled
	@hoursset =  true
else if business.friday_enabled
	@hoursset =  true
else if business.saturday_enabled
	@hoursset =  true
else if business.sunday_enabled	
	@hoursset =  true
end
@hoursset
end

