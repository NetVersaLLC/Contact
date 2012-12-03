class Getfav < ClientData
  attr_accessible :business_id, :force_update, :secrets
  virtual_attr_accessor :password

  def self.my_mail(mail)
    if mail.subject =~ /Activate Your Fave Account/
      true
    else
      false
    end
  end

  def self.get_link(mail)
    if mail.body =~ /(https:\/\/www.getfave.com\/?activate=\S+)/
      $1
    else
      nil
    end
  end

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Activate Your Fave Account/
        if mail.body =~ /(https:\/\/www.getfave.com\/?activate=\S+)/
          @link = $1
        end
      end
    end
    @link
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
		if business.monday_enabled
			hours_string += "Monday: " + business.monday_open + " - " + business.monday_close + ", "
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
