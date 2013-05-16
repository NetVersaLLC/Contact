module Business::FormMethods
  extend ActiveSupport::Concern
  included do

    def self.list_times
      list = []
      a = Time.new(0)
      48.times do |k|
        list.push (a += 1800).strftime("%I:%M%p")
      end
      list.unshift list.pop
      list
    end

    def payment_methods
      ['cash', 'checks', 'mastercard', 'visa', 'discover', 'diners', 'amex', 'paypal', 'bitcoin']
    end

    def self.gender_list
      ['Male', 'Female', 'Unknown']
    end

    def self.prefix_list
      ['Mr.', 'Mrs.', 'Miss.', 'Ms.', 'Dr.', 'Prof.']
    end

    def name
      [self.contact_first_name, self.contact_middle_name, self.contact_last_name].join(" ").gsub(/\s+/, ' ')
    end

    def state_name
      states = {"AL"=>"Alabama", "AK"=>"Alaska", "AZ"=>"Arizona", "AR"=>"Arkansas", "CA"=>"California", "CO"=>"Colorado", "CT"=>"Connecticut", "DE"=>"Delaware", "DC" => "District Of Columbia", "FL"=>"Florida", "GA"=>"Georgia", "HI"=>"Hawaii", "ID"=>"Idaho", "IL"=>"Illinois", "IN"=>"Indiana", "IA"=>"Iowa", "KS"=>"Kansas", "KY"=>"Kentucky", "LA"=>"Louisiana", "ME"=>"Maine", "MD"=>"Maryland", "MA"=>"Massachusetts", "MI"=>"Michigan", "MN"=>"Minnesota", "MS"=>"Mississippi", "MO"=>"Missouri", "MT"=>"Montana", "NE"=>"Nebraska", "NV"=>"Nevada", "NH"=>"New Hampshire", "NJ"=>"New Jersey", "NM"=>"New Mexico", "NY"=>"New York", "NC"=>"North Carolina", "ND"=>"North Dakota", "OH"=>"Ohio", "OK"=>"Oklahoma", "OR"=>"Oregon", "PA"=>"Pennsylvania", "RI"=>"Rhode Island", "SC"=>"South Carolina", "SD"=>"South Dakota", "TN"=>"Tennessee", "TX"=>"Texas", "UT"=>"Utah", "VT"=>"Vermont", "VA"=>"Virginia", "WA"=>"Washington", "WV"=>"West Virginia", "WI"=>"Wisconsin", "WY"=>"Wyoming"}
      unless states[ self.state ].nil?
        states[ self.state ]
      else
        nil
      end
    end

    def self.geographic_areas_list
      list = ['Worldwide', 'Nationwide', 'Unknown']
      number = 10
      1.upto(9) do
        list.push "Within #{number} Miles"
        number += 10
      end
      1.upto(9) do
        list.push "Within #{number} Miles"
        number += 100
      end
      list
    end

  end
end
