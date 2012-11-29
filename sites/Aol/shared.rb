def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\aol_captcha.png"
  obj = @browser.image( :xpath, '//*[@id="regImageCaptcha"]' )
  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image

  CAPTCHA.solve image, :manual
end

