class PayloadHelper < ClientData
  def self.get_hours(business,options={})
    options[:strip_leading_zeros] ||= true
    hours = {}
    hours[:days_open] = []
    time_regex = /(\d\d):(\d\d)(\w\w)/
    days = {
      monday: :mon,
      tuesday: :tues,
      wednesday: :wed,
      thursday: :thur,
      friday: :fri,
      saturday: :sat,
      sunday: :sun
    }
    days.each do |day, abbr|
      if !!business.send(:"#{day}_enabled")
        hours[:days_open] << abbr
        start = business.send(:"#{day}_open").scan(time_regex).first
        close = business.send(:"#{day}_close").scan(time_regex).first
        start_hour, start_min, start_merid = start
        end_hour, end_min, end_merid = close
        if options[:strip_leading_zeros]
          start_hour = start_hour[1..-1] if start_hour[0] == "0"
          end_hour = end_hour[1..-1] if end_hour[0] == "0"
        end
        start_time = [start_hour,start_min].join(":")
        end_time = [start_hour,start_min].join(":")
        start_merid.downcase!; end_merid.downcase!
        if options[:upcase]
          start_merid.upcase!; end_merid.upcase!
        end
        hours[:"#{abbr}:start_hour"] = start_hour
        hours[:"#{abbr}:start_minute"] = start_min
        hours[:"#{abbr}:end_hour"] = end_hour
        hours[:"#{abbr}:end_minute"] = end_min
        hours[:"#{abbr}:start_time"] = [start_hour,start_min].join(":")
        hours[:"#{abbr}:end_time"] = [end_hour,end_min].join(":")
        hours[:"#{abbr}:start_#{start_merid}"] = true
        hours[:"#{abbr}:end_#{end_merid}"] = true
        hours[:"#{abbr}:start_merid"] = start_merid
        hours[:"#{abbr}:end_merid"] = end_merid
      end
    end
    hours[:days_closed] = days.values - hours[:days_open]
    hours
  end

  def self.payment_methods(business,methods=[])
    if methods.empty?
      methods = [:cash,:checks,:visa,:mastercard,:amex,:discover,:diners]
    end
    accepted = []
    methods.each do |type|
      if business.send("accepts_#{type}".to_sym) == true
        accepted.push type
      end
    end
    accepted
  end

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end

  def self.make_secret_answer1
    Faker::Name.first_name
  end

  def self.make_secret_answer2
    Faker::Address.city
  end

end
