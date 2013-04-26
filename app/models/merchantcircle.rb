class Merchantcircle < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  belongs_to            :merchantcircle_category 

  def self.make_password
    SecureRandom.urlsafe_base64(rand()*6 + 6)
  end

  def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      # STDERR.puts "Examining: #{mail.subject}"
      if mail.subject =~ /MerchantCircle Registration Confirmation/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            # STDERR.puts "Body: #{p.decoded}"
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |link|
              # STDERR.puts "Link: #{link.attr('href')}"
              if link.attr('href') =~ /merchantcircle\.com\/r\?a=/
                @link = link.attr('href')
              end
            end
          end
        end
      end
    end
    STDERR.puts "Merchantcircle link: #{@link}"
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
      ["paypal",    'Paypal']    
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
