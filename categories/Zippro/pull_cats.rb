require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'json'




url = "http://myaccount.zip.pro/ajax.php?cn=ctre&tree_type=0&catId=0@@@0"
jroot = JSON.parse( open(url).read )

#puts(jroot)

#puts(jroot['CategoryTree']['data'])

categories = Hash.new
finalcats = Hash.new
jroot['CategoryTree']['data'].each do |item|
    puts(item['tagname'])    
    #categories[item['tagid']] = item['tagname']
    subID = item['tagid']
    subUrl = "http://myaccount.zip.pro/ajax.php?cn=ctre&tree_type=0&catId=#{subID}"
    subjson = JSON.parse( open(subUrl).read )
    subhash = Hash.new
    subjson['CategoryTree']['data'].each do |subitem|
        puts(" > " + subitem['tagname'])        
                  
      #puts(subitem['has_children'].to_s)        
        if subitem['has_children'] == false
              sub2hash = subitem['tagname']
              next
        end
        sub2ID = subitem['tagid']
        sub2Url = "http://myaccount.zip.pro/ajax.php?cn=ctre&tree_type=0&catId=#{sub2ID}"
        sub2json = JSON.parse( open(sub2Url).read )
        sub2hash = Hash.new
        sub2json['CategoryTree']['data'].each do |sub2item|
     
             puts(" > > " + sub2item['tagname'])             
             if sub2item['has_children'] == false
              sub3hash = sub2item['tagname']
              next
             end
             sub3ID = sub2item['tagid']
             sub3Url = "http://myaccount.zip.pro/ajax.php?cn=ctre&tree_type=0&catId=#{sub3ID}"
             sub3json = JSON.parse( open(sub3Url).read )
             sub3hash = Hash.new
             sub3json['CategoryTree']['data'].each do |sub3item|                
                sub3hash[sub3item['tagid']] = sub3item['tagname']
                puts(" > > > " + sub3item['tagname'])                
             
             end
             sub2hash[sub2item['tagname']] = { :sub3 => sub3hash}
        
        end
        subhash[subitem['tagname']] = { :sub2 => sub2hash }
    sleep(2)
    end
    categories[item['tagname']] = { :sub1 => subhash }
    
    sleep(5)
    
end
finalcats = categories


file = File.open("categories.json", "w")
	file.write(finalcats.to_json)
file.close unless file == nil


