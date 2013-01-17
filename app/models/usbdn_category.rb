class UsbdnCategory < SiteCategory
	attr_accessible :name, :parent_id  
	acts_as_tree :order => :name
	belongs_to :google_category
	has_many :usbdns
end
