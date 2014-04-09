class Shopinusa < ClientData
  #attr_accessible :shopinusa_category_id
  belongs_to :shopinusa_category

  def self.get_hours(business)
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
        start_hour = start_hour[1..-1] if start_hour[0] == "0"
        end_hour = end_hour[1..-1] if end_hour[0] == "0"
        start_merid.downcase!; end_merid.downcase!
        hours[:"#{abbr}:start_hour"] = start_hour
        hours[:"#{abbr}:start_minute"] = start_min
        hours[:"#{abbr}:end_hour"] = end_hour
        hours[:"#{abbr}:end_minute"] = end_min
        hours[:"#{abbr}:start_#{start_merid}"] = true
        hours[:"#{abbr}:end_#{end_merid}"] = true
      end
    end
    hours[:days_closed] = days.values - hours[:days_open]
    hours
  end

  def self.payment_methods(business)
    methods = {}
    methods = [:cash,:checks,:visa,:mastercard,:amex,:discover,:diners]
    accepted = []
    methods.each do |type|
      if business.send("accepts_#{type}".to_sym) == true
        accepted.push type
      end
    end
    accepted
  end
end
