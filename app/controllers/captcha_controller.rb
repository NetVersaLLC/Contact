require 'tempfile'

class CaptchaController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def recaptcha
    file = Tempfile.new('temp')
    file.binmode
    file.write(params['image'].read())
    file.close
    client = DeathByCaptcha.http_client('netversa', 'GSbjMIe9Ja')
    res = client.decode file.path
    render json: {'answer' => res['text']}
  end
end
