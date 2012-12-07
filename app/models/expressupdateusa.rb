class Expressupdateusa < ClientData
 attr_accessible :email
  virtual_attr_accessor :password	
validates :email,
            :allow_blank => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
 
  def self.check_email(business)
    @link = nil
    STDERR.puts( "test test, is this thing on?" )
    CheckMail.get_link(business) do |mail|
	    STDERR.puts "Does this even work?"
      if mail.subject =~ /Please Confirm Your Email Address - ExpressUpdate/i
	      STDERR.puts "subject found"
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |link|
              if link.attr('href') =~ /https:\/\/listings.expressupdateusa.com\/Account\/Activate/i
                @link = link.attr('href')
              end
            end
          end
        end
      end
    end
    STDERR.puts "Expressupdate link: #{@link}"
    @link
  end

   def self.payment_methods(business)
    methods = {}
    [
      ["cash",      'CashOnly'],
      ["checks",    'PersonalChecks'],
      ["visa",      'Visa'],
      ["mastercard",'Mastercard'],
      ["amex",      'AmericanExpress'],
      ["discover",  'Discover'],
      ["diners",    'DinersClub']
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
 


end
