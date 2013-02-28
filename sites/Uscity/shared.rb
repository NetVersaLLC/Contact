def search_business(data)
  $matching_result = false
  @browser.text_field(:id=> 'link_category_slug').set data[ 'business' ]
  @browser.text_field(:id=> 'link_search_city').value = data[ 'city' ]
  sleep(3)
  @browser.text_field(:id=> 'link_search_city').send_keys(:down)
  @browser.send_keys(:return)
  @browser.link(:text => 'Search').click
  if @browser.div(:class=> 'fleft width480').div(:class=>'boxborder').link(:text=> "#{data[ 'business']}").exist?
        $matching_result = true
  end
  return $matching_result
end

def solve_captcha
  image = "#{ENV['USERPROFILE']}\\citation\\uscity_captcha.png"
  obj = @browser.image(:src, /recaptcha\/api\/image/)
  puts "CAPTCHA source: #{obj.src}"
  puts "CAPTCHA width: #{obj.width}"
  obj.save image
  captcha_text = CAPTCHA.solve image, :manual
  return captcha_text
end

def enter_captcha

  capSolved = false
  count = 1
  until capSolved or count > 5 do
  captcha_code = solve_captcha
  @browser.text_field( :id, 'recaptcha_response_field').set captcha_code
  @browser.button(:value => 'SUBMIT').click

    if not @browser.html.include?('Add Your Listing')
      capSolved = true
    end
  count+=1
  end

  if capSolved == true
    true
  else
  throw("Captcha was not solved")
  end
end
