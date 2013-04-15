class Yellowassistance < ClientData
	attr_accessible :username, :secret_answer, :yellowassistance_category_id, :yellowassistance_category
	virtual_attr_accessor :password
belongs_to :yellowassistance_category

def self.payment_methods(business)
    methods = {}
    [
      ["visa",      'Visa'],
      ["mastercard",'Mastercard'],
      ["amex",      'AmEx'],
      ["discover",  'Discover'],
      ["diners",    'Diners']
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



def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
      if mail.subject =~ /Welcome to Yellow Assistance.com!/i
        mail.parts.map do |p|
          if p.content_type =~ /text\/html/
            nok = Nokogiri::HTML(p.decoded)
            nok.xpath("//a").each do |tink|
              if tink.attr('href') =~ /http:\/\/www.yellowassistance.com\/frmVerifyRegistration.aspx/i
                @link = tink.attr('href')
                puts(@link)
              end
            end
          end
        end
      end  
    end      
    @link
  end



end
