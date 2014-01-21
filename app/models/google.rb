class Google < ClientData
  attr_accessible       :email,:cookies, :places_url, :status
  virtual_attr_accessor :password, :secret_answer

  belongs_to            :google_category, foreign_key: "category_id"
  def has_categories? 
    false
  end

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 8)
  end

  def self.make_email_names(business)
    name = business.business_name.gsub(/\s+|[^A-Za-z0-9]+/, '')
    choices = [name]
    choices.push name + business.zip
    choices.push name + '1'
    choices.push name + business.city.gsub(/\s+|[^A-Za-z0-9]+/, '')
    choices.push name + business.year_founded.to_s
    choices.each do |choice|
      choice.downcase! if (rand()*10) > 5
    end
    choices.sort_by { rand }
  end

  def self.get_hours(business)
    hours = {}
    days = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday']
    days.each do |day|
        if business.send("#{day}_enabled".to_sym) == true
            hours[ "#{day}" ] =
                [
                    business.send("#{day}_open".to_sym).downcase.gsub("am"," am").gsub("pm"," pm"),
                    business.send("#{day}_close".to_sym).downcase.gsub("am"," am").gsub("pm"," pm")
                ]

        else
          hours[ "#{day}" ] = ""
        end
    end
        return hours
  end  

end
