require 'nokogiri'
require 'open-uri'
require 'json'

categories = []
url = 'http://www.mysheriff.net/getTypeOfBusiness.php?q='
(:a..:z).to_a.each do |letter|
  page = Nokogiri::HTML open [url,letter].join
  categories += page.text.split(/\|\d+\n/)
end
file = File.open("categories.json","w")
file.write categories.to_json
file.close
