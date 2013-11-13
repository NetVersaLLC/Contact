class Twitter < ClientData
  attr_accessible :username, :twitter_page
  virtual_attr_accessor :password

  def has_categories? 
    false
  end 


def self.check_email(business)
    @link = nil
    CheckMail.get_link(business) do |mail|
    	if mail.subject =~ /Confirm your Twitter account/i
       		puts(mail.subject)
       		mail.parts.map do |p|
       			if p.content_type =~ /text\/html/
           			#puts p.decoded
           			nok = Nokogiri::HTML(p.decoded)
					@link = nok.xpath("//a")[2].attr('href') #.each do |tink|
						#puts tink.attr('href')
						#if tink.attr('href') =~ /https:\/\/twitter.com\/i\/redirect?url=https:\/\/twitter.com\/account\//i
	           				#tink.attr('href')[1]
	           				puts("THE LINK: "+@link)
						#end
					#end
       			end
       		end
    	end
    end
    @link
end

end
