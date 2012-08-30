require 'tempfile'

class CaptchaController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def recaptcha
    file = Tempfile.new('temp')
    file.write(params['image'].read)
    file.close
    client = DeathByCaptcha.socket_client('netversa', 'kmiA$zQ9o2')
    res = client.decode file.path
    render json: {'answer' => res['text']}
  end
end
