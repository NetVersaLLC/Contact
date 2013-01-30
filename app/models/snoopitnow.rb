class Snoopitnow < ClientData
	attr_accessible :username, :snoopitnow_category_id
	virtual_attr_accessor :password
	validates :password,
            :presence => true
belongs_to            :snoopitnow_category
end
