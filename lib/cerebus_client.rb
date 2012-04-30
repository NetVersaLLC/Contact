require "net/https"
require "uri"
require 'json'
require 'cerebus'

class CerebusClient

  def dump(obj)
    return nil unless obj
    STDERR.puts "dump(#{obj})"
    Cerebus.encrypt obj.to_json, Rails.root.join("config", "public.pem")
  end

  def load(secret)
    return nil unless secret
    STDERR.puts "load(#{secret})"
    uri              = URI("#{CEREBUS_SERVER}#{CEREBUS_KEY}.json")
    pem              = File.read(Rails.root.join("config", "cerebus_server.pem"))
    http             = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl     = true
    http.cert        = OpenSSL::X509::Certificate.new(pem)
    http.key         = OpenSSL::PKey::RSA.new(pem)
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    req              = Net::HTTP::Post.new(uri.path)
    req.set_form_data('secret' => secret)
    res = http.request req
    STDERR.puts res.body
    JSON(res.body)
  end

end
