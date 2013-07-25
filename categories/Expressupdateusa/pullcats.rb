require "nokogiri"
require "open-uri"

states = Array.[](
  "Alabama-AL",
  "Alaska-AK",
  "Arizona-AZ",
  "Arkansas-AR",
  "California-CA",
  "Colorado-CO",
  "Connecticut-CT",
  "Delaware-DE",
  "District%20of%20Columbia-DC",
  "Florida-FL",
  "Georgia-GA",
  "Hawaii-HI",
  "Idaho-ID",
  "Illinois-IL",
  "Indiana-IN",
  "Iowa-IA",
  "Kansas-KS",
  "Kentucky-KY",
  "Louisiana-LA",
  "Maine-ME",
  "Maryland-MD",
  "Massachusetts-MA",
  "Michigan-MI",
  "Minnesota-MN",
  "Mississippi-MS",
  "Missouri-MO",
  "Montana-MT",
  "Nebraska-NE",
  "Nevada-NV",
  "New%20Hampshire-NH",
  "New%20Jersey-NJ",
  "New%20Mexico-NM",
  "New%20York-NY",
  "North%20Carolina-NC",
  "North%20Dakota-ND",
  "Ohio-OH",
  "Oklahoma-OK",
  "Oregon-OR",
  "Pennsylvania-PA",
  "Rhode%20Island-RI",
  "South%20Carolina-SC",
  "South%20Dakota-SD",
  "Tennessee-TN",
  "Texas-TX",
  "Utah-UT",
  "Vermont-VT",
  "Virginia-VA",
  "Washington-WA",
  "West%20Virginia-WV",
  "Wisconsin-WI",
  "Wyoming-WY"
)

file = File.open("categories.txt","w")
stateloop = 0
until stateloop == states.length
	url = "http://listings.expressupdateusa.com/Directory/#{states[stateloop]}"
	page = Nokogiri::HTML(open(url))
	cities = []
	page.css('div.section.first a').each do |city|
  		cities.push(city.text)
	end
citycount = cities.length
cityloop = 0
load = (100.0 / citycount)
progress = 0
$stdout.sync = true
until cityloop == citycount
	cityhref = "http://listings.expressupdateusa.com" + page.at_xpath("//a[text()='#{cities[cityloop]}']/@href")
	if cityhref == "http://listings.expressupdateusa.com/Account/Register" then
		cityhref = "http://listings.expressupdateusa.com/Directory/#{states[stateloop]}/REGISTER"
	end
	citypage = Nokogiri::HTML(open(cityhref))
	citypage.css('div.section.first a').each { |category| file.write(category.text + "\n") }
	current = progress += load
	print("\rProgress: #{current.round(2)}%")
	cityloop += 1
end
$stdout.sync = false
stateloop += 1
puts("")
puts("#{stateloop} of #{states.length} completed" + "\n")
end

puts("NOTICE: Script End - Success")