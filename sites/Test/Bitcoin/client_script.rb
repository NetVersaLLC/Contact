total = 'unknown'
browser = Watir::Browser.start 'http://mtgox.com'
if browser.text =~ /High:\$([0-9\.]+)/i
  total = $1
end
browser.close
mb = Win32API.new("user32", "MessageBox", ['i','p','p','i'], 'i')
mb.call(0, total , 'Bitcoin Price', 0)

true
