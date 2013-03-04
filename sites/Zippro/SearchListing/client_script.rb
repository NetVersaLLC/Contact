require 'nokogiri'
url = "http://#{data['zip']}.zip.pro/#{data['businessfixed']}"
puts(url)
page = Nokogiri::HTML(RestClient.get(url)) 
if not page.css("div.organicListing").length == 0
  puts("1")
  link = page.css("a.result-title")
  link = link[0]["href"]
  subpage = Nokogiri::HTML(RestClient.get(link)) 
  puts("2")
  claimLink = subpage.css("a#a_prof_claim")
  if claimLink.length == 0
    businessFound = [:listed, :claimed]
    puts("3")
  else
    businessFound = [:listed, :unclaimed]
    puts("4")
  end 
else
  businessFound = [:unlisted]
  puts("5")
end


[true, businessFound]