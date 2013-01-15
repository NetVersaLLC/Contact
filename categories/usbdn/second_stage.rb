require 'nokogiri'
require 'open-uri'
require 'rest_client'
require 'json'

url = "http://www.usbdn.com/BizRegistrationStep1.asp?DisplaySelectionForm=1&ChooseSubCat=1&Changed=1&SubCatId1=0&SubCatId2=0&SubCatId3=0"

second = {
  :CatId          => 17,
  :ParentSubCatId => 1129,
  :SubCatId       => 0,
  :SubCatId1      => 0,
  :SubCatId2      => 0,
  :SubCatId3      => 0
}

cats = JSON.parse File.open("cats_first.json", "r").read

cats.each_with_index do |top, i|
  second[:CatId] = top[0]
  puts "#{top[1]}: "
  top[2].each_with_index do |sec, j|
      puts "#{sec[1]}: "
      second[:ParentSubCatId] = sec[0]
      html                    = RestClient.post url, second
      nok                     = Nokogiri::HTML( html )
      nok.xpath("//select[@name='SubCatId']/option").each do |option|
        next if option['value'] == '0'
        puts "\t#{option['value']}: #{option.inner_text}"
        cats[i][2][j][2].push [ option['value'], option.inner_text ]
      end
  end
end

File.open("cats_second.json", "w").write JSON( cats )
