require 'net/http'
require 'json'
require 'cerebus'

class CerebusClient

  def load(obj)
    Cerebus.encrypt obj.to_json, Rails.root.join("config", "public.pem")
  end

  def dump(secret)
    uri = URI("#{CEREBUS_SERVER}#{CEREBUS_KEY}.json")
    res = Net::HTTP.post_form(uri, 'secret' => secret)
    JSON(res.body)
  end

end
