require 'json'

namespace :usbdn do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "usbdn", "cats_second.json"), 'r').read
    categories = JSON.parse(body) #UsbdnCategory.create(body)
	#

	categories.each do |layer1|
	root = UsbdnCategory.create(:name => layer1[1])		
		layer1[2].each do |layer2|
		cat = root.children.create(:name => layer2[1])			
			layer2[2].each do |layer3|
				sub = cat.children.create(:name => layer3[1])
			end
		end
	end
				
	
  end
end
