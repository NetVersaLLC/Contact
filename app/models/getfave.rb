class Getfave < ClientData
  attr_accessible :email, :status
  virtual_attr_accessor :password

  def has_categories? 
    false
  end 

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      # STDERR.puts "Examining: #{mail.subject}"
      if mail.subject =~ /Activate Your Fave Account/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            # STDERR.puts "Body: #{p.decoded}"
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |link|
              # STDERR.puts "Link: #{link.attr('href')}"
              if link.attr('href') =~ /getfave.com\/\?activate/i
                @link = link.attr('href')
              end
            end
          end
        end
      end
    end
    STDERR.puts "Getfav link: #{@link}"
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
