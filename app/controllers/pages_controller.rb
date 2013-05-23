class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def contact_us
  end

  def make_redirect
    if user_signed_in?
      redirect_to '/businesses'
    else
      redirect_to '/users/sign_up?package_id=1'
    end
  end

  def try_again_later
  end

  def resellers
  end
end
