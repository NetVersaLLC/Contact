class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_label
    label = Label.where(:domain => request.host).first
    unless label
      label = Label.first
    end
    label
  end
end
