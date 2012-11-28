def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\yellowbot_captcha.png"
  obj = @browser.image( :xpath, "/html/body/div[3]/div/div[2]/div/div/div/div/div/div[2]/form/fieldset/div/div/table/tbody/tr[2]/td[2]/div/img" )
  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image

  CAPTCHA.solve image, :manual
end

def solve_captcha2
  image = "#{ENV['USERPROFILE']}\\citation\\yellowbot2_captcha.png"
  obj = @browser.image( :xpath, "/html/body/div[3]/div/div[2]/div/div/div/div/div/div/div/form/div/div/table/tbody/tr[2]/td[2]/div/img" )
  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image

  CAPTCHA.solve image, :manual
end
