def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\mojopages_captcha.png"
  obj = @browser.image( :xpath, "/html/body/div/div[3]/div[2]/div/div[2]/div[2]/div/div[3]/form/div[5]/div/div/div/table/tbody/tr[2]/td[2]/div/img" )
  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image

  CAPTCHA.solve image, :manual
end




