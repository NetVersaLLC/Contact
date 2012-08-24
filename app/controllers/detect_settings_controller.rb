class DetectSettingsController < ApplicationController
  ## NOTE
  ## This could be abused, if say a cracker wanted to have us
  ## do the job of testing email accounts. Can ignore this
  ## until after the beta. Perhaps we can put in a limit
  ## per-ip / per-session.
  def detect
    @email    = params[:email]
    @password = params[:password]
    @settings = DetectEmailSettings.detect_known_only @email, @password
    render json: @settings
  end
end
