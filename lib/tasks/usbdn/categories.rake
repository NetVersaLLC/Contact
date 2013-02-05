require 'json'

namespace :usbdn do
  task :categories => :environment do
	body = File.open(Rails.root.join("categories", "usbdn", "cats_second.json"), 'r').read
    categories = JSON.parse(body) #UsbdnCategory.create(body)
	#
root = UsbdnCategory.create(:name => 'root')
	categories.each do |layer1|
	node1 = UsbdnCategory.create(:name => layer1[1], :parent_id => root.id)		
		layer1[2].each do |layer2|
		node2 = node1.children.create(:name => layer2[1], :parent_id => node1.id)			
			layer2[2].each do |layer3|
				node3 = node2.children.create(:name => layer3[1], :parent_id => node2.id)
			end
		end
	end
				
	
  end
end
 