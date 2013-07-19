class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def contact_us
  end

  def make_redirect
    current_label
    if user_signed_in?
      redirect_to '/businesses'
    else
      redirect_to '/users/sign_in'
    end
  end

  def try_again_later
  end

  def resellers
    redirect_to admin_root_url
  end

  def congratulations

  end

  def begin_sync
    # the code to sync will come here ...
    render :layout=>nil
  end
end
