#class Kudzu

#    include HTTParty
#    format :json
#    base_uri "http://cite.netversa.com"
#    debug_output

#    def self.notify_of_join( key )
#        get( "/kudzus/check_email.json?auth_token=#{key}" )
#    end

#end
