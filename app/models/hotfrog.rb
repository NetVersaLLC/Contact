class Hotfrog < ClientData
  attr_accessible :email
  virtual_attr_accessor :password
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :password,
            :presence => true

def self.payment_methods(business)
    methods = {}
    [
      ["visa",        'ctl00_contentSection_ctrlPaymentTypes_StandardPaymentTypesList_0'],
      ["mastercard",  'ctl00_contentSection_ctrlPaymentTypes_StandardPaymentTypesList_1'],
      ["amex",        'ctl00_contentSection_ctrlPaymentTypes_StandardPaymentTypesList_2'],
      ["diners",      'ctl00_contentSection_ctrlPaymentTypes_StandardPaymentTypesList_3'],
      ["cash",        'ctl00_contentSection_ctrlPaymentTypes_StandardPaymentTypesList_4'],
      ["paypal",      'ctl00_contentSection_ctrlPaymentTypes_StandardPaymentTypesList_6'],
      ["checks",      'ctl00_contentSection_ctrlPaymentTypes_StandardPaymentTypesList_8']
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
  	if mail.subject =~ /Validate your profile on Hotfrog/i
		if mail.body.decoded =~ /(http:\/\/www.hotfrog.com\/\S+)/i
	          @link = $1
	        end
  	end
    end
    @link
 end
end
