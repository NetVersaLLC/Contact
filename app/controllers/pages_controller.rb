class PagesController < ApplicationController
  def contact_us
  end

  def make_redirect
    if user_signed_in?
      redirect_to '/businesses'
    else
      redirect_to '/users/sign_in'
    end
  end
end
