class Usyellowpages < ClientData 
  attr_accessible 		:email
  virtual_attr_accessor :password
  belongs_to            :usyellowpages_category


  def self.payment_methods(business)
    methods = {}
    [
      ["cash",      'Group-0-PaymentOption_Cash'],
      ["checks",    'Group-0-PaymentOption_Check'],
      ["visa",      'Group-0-PaymentOption_Visa'],
      ["mastercard",'Group-0-PaymentOption_Master-Card'],
      ["amex",      'Group-0-PaymentOption_American-Express'],
      ["discover",  'Group-0-PaymentOption_Discover'],
      ["diners",    'Group-0-PaymentOption_Diners']
    ].each do |row|
      methods[row[0]] = row[1]
    end
    accepted = []
    methods.each_key do |type|
      if business.send("accepts_#{type}".to_sym) == true
        accepted.push methods[type]
      end
    end
    accepted
  end
  
    def self.consolidate_hours( business )
    hours_string = ""
    if business.monday_enabled
      hours_string += "Monday: " + business.monday_open + " - " + business.monday_close + ", "
    end
    if business.tuesday_enabled
      hours_string += "Tuesday: " + business.tuesday_open + " - " + business.tuesday_close + ", "
    end     
    if business.wednesday_enabled
      hours_string += "Wednesday: " + business.wednesday_open + " - " + business.wednesday_close + ", "
    end
    if business.thursday_enabled
      hours_string += "Thursday: " + business.thursday_open + " - " + business.thursday_close + ", "
    end
    if business.friday_enabled
      hours_string += "Friday: " + business.friday_open + " - " + business.friday_close + ", "
    end
    if business.open_by_appointment
      hours_string += "Open by Appointment, "
    end
    if business.open_24_hours
      hours_string += "Open 24 Hours"
    end
    hours_string
  end

  
end
