require 'nokogiri'
require 'open-uri'
require 'rest_client'
require 'json'

url = "http://www.usbdn.com/BizRegistrationStep1.asp?ChooseSubCat=1"

top_cats = {}
nok = Nokogiri::HTML( open(url).read )
nok.xpath("//select[@name='CatId']/option").each do |option|
  next if option['value'] == '0'
  top_cats[option['value']] = option.inner_text
  puts "#{option['value']}: #{option.inner_text}"
end

cats = [
]

first = {
  :CatId          => 13,
  :ParentSubCatId => 0,
  :SubCatId       => 0,
  :SubCatId1      => 0,
  :SubCatId2      => 0,
  :SubCatId3      => 0
}
url = "http://www.usbdn.com/BizRegistrationStep1.asp?DisplaySelectionForm=1&ChooseSubCat=1&Changed=1&SubCatId1=0&SubCatId2=0&SubCatId3=0"
top_cats.each_key do |id|
  first[:CatId] = id
  html          = RestClient.post url, first
  nok           = Nokogiri::HTML( html )
  thisCat       = [id, top_cats[id], []]
  cats.push thisCat
  nok.xpath("//select[@name='ParentSubCatId']/option").each do |option|
    next if option['value'] == '0'
    puts "#{option['value']}: #{option.inner_text}"
    thisCat[2].push [ option['value'], option.inner_text, [] ]
  end
end

second = {
  :CatId          => 17,
  :ParentSubCatId => 1129,
  :SubCatId       => 0,
  :SubCatId1      => 0,
  :SubCatId2      => 0,
  :SubCatId3      => 0
}

File.open("cats_first.json", "w").write JSON( cats )
