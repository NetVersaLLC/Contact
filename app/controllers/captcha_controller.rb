require 'tempfile'

class CaptchaController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def recaptcha
    business = Business.where(:id => params[:business_id]).first
    if business.captcha_solves > 0 and business.user_id == current_user.id
      file = Tempfile.new('temp')
      file.binmode
      file.write(params['image'].read())
      file.close
      business.captcha_solves -= 1
      business.save :validate => false
      client = DeathByCaptcha.http_client('netversa', 'GSbjMIe9Ja')
      res = client.decode file.path
      if res and res.length > 0 and res['text']
        render json: {'answer' => res['text']}
      else
        render json: {'error' => 'not found'}
      end
    else
      render json: {'error' => 'not authorized'}
    end
  end
end
